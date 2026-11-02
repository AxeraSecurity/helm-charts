-- association.lua: the shipper's process-to-pod association (association contract schema 2). Runs in the shipper's
-- Lua filter (LuaJIT 2.1; Lua 5.1/5.4 compatible) on every sensor event, before Kafka.
--
-- Product-independent by construction: it never looks at a binary name, a runtime handler, a CRI socket or a
-- product. For an event whose process the sensor left without a pod it reads, in order:
--   1. the identity already learned for the event's exec_id (bounded two-generation LRU, 1 h TTL; the identity
--      tables are interned, so the processes of one container share one table and an entry costs its key);
--   2. /proc/<pid>/stat, /proc/<pid>/cgroup, /proc/<pid>/stat again (the agent pod shares the host PID namespace),
--      parsed by cgparse at any depth; accepted only when the process is still the one of the event: its start time
--      (stat field 22, clock ticks) is not later than the event's exec_id ktime (+1 tick), and unchanged across the
--      cgroup read. A pid reused by a later process is rejected, never attributed;
--   3. its parent's identity (by the parent's exec_id): a forked process inherits its parent's cgroup, so a child
--      that exited before step 2 still names its pod through an ancestor the shipper or the sensor resolved.
-- The answer goes out as NEW fields, process.axera_cgroup = { pod_uid, pod_uid_form, container_id, role, depth,
-- relative, layout, source } (and parent_pod when inherited from a parent the sensor attributed); the sensor's own
-- fields are never overwritten. Radar maps pod_uid / container_id to the pod from the pod list it already reads.
-- Every 60 s the filter turns a tick into one association_health record per node (counts by source, layout
-- histogram, containers seen in the window with several sub-cgroups, self-check agreement), so a degraded node is
-- visible, never silent.
local A = {}

A.proc = "/proc"          -- the shipper's own /proc lists every host pid (pod hostPID: true)
A.TICK_NS = 10000000      -- USER_HZ = 100 on every Linux architecture Kubernetes runs on
A.CAP = 32768             -- identities kept (two generations of CAP/2)
A.TTL = 3600              -- seconds an identity is trusted
A.SELF_CHECK_EVERY = 100  -- one in this many new sensor-attributed processes is also parsed (agreement)
A.MAX_CHILD_TRACK = 4096  -- containers whose sub-cgroup names are tracked for the multi-child count
A.MAX_INTERNED = 4096     -- distinct identities shared by the cache entries (wiped whole when exceeded)

local cg -- the cgparse module, set by A.init

-- exec_id -> identity and exec_id -> when it was learned, in two generations. Identities are interned (one shared
-- table per distinct identity, never mutated after it is cached): an entry costs its key and two slots, not the
-- one to three tables per process it took before. Measured in the shipper image's LuaJIT on a busy cluster's event
-- mix: the Lua heap ~5 MB above a filter without the association instead of ~19 MB (full cache, same CPU).
local cur, prev, ncur = {}, {}, 0
local cur_t, prev_t = {}, {}
local interned, ninterned = {}, 0
local counts, layout, depth_hist = {}, {}, {}
local check = { checked = 0, agree = 0, disagree = 0 }
local children, nchildren = {}, 0
local active = {} -- container ids whose cgroup was parsed in the current heartbeat window
local new_sensor = 0

function A.init(cgparse) cg = cgparse end

local function bump(t, k, n) t[k] = (t[k] or 0) + (n or 1) end
local function str(v) if type(v) == "string" then return v end return "" end

-- ---- bounded identity cache (exec_id -> identity) ----------------------------------------------------------
local function rotate()
  prev, prev_t, cur, cur_t, ncur = cur, cur_t, {}, {}, 0
end

local function cache_get(k, now)
  if k == nil or k == "" then return nil end
  local v, t = cur[k], cur_t[k]
  if v == nil then
    v, t = prev[k], prev_t[k]
    if v == nil then return nil end
    prev[k], prev_t[k] = nil, nil
    if ncur >= A.CAP / 2 then rotate() end
    cur[k], cur_t[k], ncur = v, t, ncur + 1
  end
  if now - t > A.TTL then cur[k], cur_t[k] = nil, nil; return nil end
  return v
end

local function cache_put(k, v, now)
  if k == nil or k == "" then return end
  if cur[k] == nil then
    if ncur >= A.CAP / 2 then rotate() end
    ncur = ncur + 1
  end
  cur[k], cur_t[k] = v, now
end

-- The one shared table for an identity's content (v itself the first time). Only the fields an identity carries
-- take part; a pod reference by its namespace, name, workload, kind and container name.
local function pod_key(p)
  if type(p) ~= "table" then return "" end
  local c = type(p.container) == "table" and p.container or {}
  return table.concat({ tostring(p.namespace), tostring(p.name), tostring(p.workload), tostring(p.workload_kind),
                        tostring(c.name) }, "/")
end

local function intern(v)
  local key = table.concat({ tostring(v.source), tostring(v.pod_uid), tostring(v.pod_uid_form), tostring(v.container_id),
                             tostring(v.role), tostring(v.depth), tostring(v.relative), tostring(v.layout),
                             pod_key(v.sensor_pod), pod_key(v.parent_pod) }, "|")
  local hit = interned[key]
  if hit ~= nil then return hit end
  if ninterned >= A.MAX_INTERNED then interned, ninterned = {}, 0 end
  interned[key], ninterned = v, ninterned + 1
  return v
end
A.intern = intern
A.cache_get, A.cache_put = cache_get, cache_put
function A.cache_size() local n = 0 for _ in pairs(prev) do n = n + 1 end return ncur + n end
function A.interned_size() return ninterned end

-- ---- exec_id and /proc ---------------------------------------------------------------------------------------
local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local B64IDX = {}
for i = 1, 64 do B64IDX[B64:sub(i, i)] = i - 1 end

function A.b64decode(s)
  local out, bits, nbits = {}, 0, 0
  for i = 1, #s do
    local c = s:sub(i, i)
    if c == "=" then break end
    local v = B64IDX[c]
    if v == nil then return nil end
    bits = bits * 64 + v; nbits = nbits + 6
    if nbits >= 8 then
      nbits = nbits - 8
      local b = math.floor(bits / 2 ^ nbits)
      out[#out + 1] = string.char(b)
      bits = bits - b * 2 ^ nbits
    end
  end
  return table.concat(out)
end

-- exec_id = base64("<node>:<ktime ns>:<pid>") -> ktime (a Lua number; above 2^53 ns, ~104 days of uptime, it keeps a
-- few ns of resolution, far finer than the 10 ms tick the guard compares at), pid
function A.exec_id_parts(exec_id)
  if type(exec_id) ~= "string" or exec_id == "" then return nil end
  local s = A.b64decode(exec_id)
  if not s then return nil end
  local kt, pid = s:match(":(%d+):(%d+)$")
  if not kt then return nil end
  return tonumber(kt), tonumber(pid)
end

-- The file's content, or nil + "gone" (no such process) | "unreadable" (it exists, but the shipper may not read it:
-- a hardened /proc, an LSM denial — reported, never mistaken for an exited process).
local function read_all(path)
  local f, err = io.open(path, "r")
  if not f then
    if type(err) == "string" and (err:find("ermission", 1, true) or err:find("not permitted", 1, true)) then return nil, "unreadable" end
    return nil, "gone"
  end
  -- open() can succeed and read() still fail: the process exited in between (ESRCH). That is "gone", never a
  -- reason-less nil (counting a nil reason fails with "table index is nil").
  local c = f:read("*a"); f:close()
  if c == nil then return nil, "gone" end
  return c
end

-- stat field 22 (starttime, ticks); comm (field 2) can hold spaces and ')', so parse after the LAST ')'
function A.stat_start_ticks(stat)
  local rest = stat and stat:match(".*%)%s+(.*)$")
  if not rest then return nil end
  local i = 3
  for tok in rest:gmatch("%S+") do
    if i == 22 then return tonumber(tok) end
    i = i + 1
  end
end

-- The identity of the event's process from /proc, or nil + "no_exec_id" | "gone" | "unreadable" | "pid_reused" |
-- "host".
function A.read_identity(exec_id, pid_hint)
  local ktime, pid = A.exec_id_parts(exec_id)
  if not ktime then return nil, "no_exec_id" end
  pid = pid or pid_hint
  local base = A.proc .. "/" .. tostring(pid)
  local stat, why = read_all(base .. "/stat")
  local start = A.stat_start_ticks(stat)
  if not start then return nil, why or "gone" end
  if start * A.TICK_NS > ktime + A.TICK_NS then return nil, "pid_reused" end
  local cgroup, why2 = read_all(base .. "/cgroup")
  if not cgroup then return nil, why2 or "gone" end
  local start2 = A.stat_start_ticks((read_all(base .. "/stat")))
  if start2 == nil then return nil, "gone" end
  if start2 ~= start then return nil, "pid_reused" end
  local r = cg.parse_proc_cgroup(cgroup)
  if not r then return nil, "host" end
  return r
end

-- ---- health bookkeeping --------------------------------------------------------------------------------------
local function note_layout(r)
  local l = cg.layout(r)
  bump(layout, l)
  if l == "nested" then
    local d = r.depthBelowContainer or 0
    bump(depth_hist, d >= 3 and "3+" or tostring(d))
  end
  -- two or more distinct sub-cgroups seen under one container cgroup (a sensor-side pod selector that descends
  -- into a single child misses such a layout)
  local cid, child = r.containerId, r.child
  if cid and child then
    local set = children[cid]
    if set == nil then
      if nchildren >= A.MAX_CHILD_TRACK then children, nchildren = {}, 0 end
      set = { n = 0 }; children[cid] = set; nchildren = nchildren + 1
    end
    if not set[child] then set[child] = true; set.n = set.n + 1 end
    active[cid] = true
  end
end

local HOST = { role = "host", source = "host_by_cgroup" } -- the one identity of every proven host process

local function to_identity(r, source)
  return { pod_uid = r.podUid, pod_uid_form = r.podUidForm, container_id = r.containerId, role = r.role,
           depth = r.depthBelowContainer, relative = r.relative, layout = cg.layout(r), source = source }
end

-- What goes on the event (a fresh table: the cached identity is never handed out to be mutated).
function A.fields(id)
  if id == nil then return nil end
  return { pod_uid = id.pod_uid, pod_uid_form = id.pod_uid_form, container_id = id.container_id, role = id.role,
           depth = id.depth, relative = id.relative, layout = id.layout, source = id.source,
           parent_pod = id.parent_pod }
end

-- The parent's exec_id: parent.exec_id (field filter) or process.parent_exec_id.
local function parent_exec_id(proc, parent)
  if type(parent) == "table" and str(parent["exec_id"]) ~= "" then return parent["exec_id"] end
  return str(proc["parent_exec_id"])
end

local function sensor_pod_ref(pod)
  local c = type(pod["container"]) == "table" and pod["container"] or {}
  return { namespace = pod["namespace"], name = pod["name"], workload = pod["workload"],
           workload_kind = pod["workload_kind"], container = { name = c["name"] } }
end

-- Resolves one event's process. Returns identity (or nil), source:
--   "sensor"            the sensor named the pod (nothing to do; learned for the children; 1 in 100 self-checked)
--   "cgroup_proc"       /proc read now or earlier for this exec_id
--   "chain"             inherited from the parent's identity
--   "host_by_cgroup"    /proc proves a host cgroup
--   "gone" | "unreadable" | "pid_reused" | "unattributed"
-- kind ("connect" | "exec" | nil) only splits the count of a process gone before it could be read: "gone_connect"
-- for a connect (mostly an application's short-lived process: a real miss), "gone" for anything else
-- (mostly the runtime's own short-lived plumbing).
-- The returned identity carries .check = { agree = bool } on a self-checked sensor event.
function A.resolve(proc, parent, now, kind)
  if type(proc) ~= "table" then bump(counts, "unattributed"); return nil, "unattributed" end
  local exec_id = str(proc["exec_id"])
  if type(proc["pod"]) == "table" then
    bump(counts, "sensor")
    if exec_id == "" or cache_get(exec_id, now) then return nil, "sensor" end
    local ident = { sensor_pod = sensor_pod_ref(proc["pod"]), source = "sensor" }
    new_sensor = new_sensor + 1
    local docker = str(proc["docker"])
    if docker ~= "" and new_sensor % A.SELF_CHECK_EVERY == 0 then
      local r = A.read_identity(exec_id, proc["pid"])
      if r and r.containerId then
        check.checked = check.checked + 1
        local agree = r.containerId:sub(1, #docker) == docker
        if agree then check.agree = check.agree + 1 else check.disagree = check.disagree + 1 end
        local id = to_identity(r, "self_check")
        id.sensor_pod = ident.sensor_pod
        id = intern(id)
        cache_put(exec_id, id, now)
        return id, "sensor"
      end
    end
    cache_put(exec_id, intern(ident), now)
    return nil, "sensor"
  end

  local hit = cache_get(exec_id, now)
  if hit and hit.source ~= "sensor" and hit.source ~= "self_check" then
    bump(counts, hit.source)
    return hit, hit.source
  end

  local r, why = A.read_identity(exec_id, proc["pid"])
  if r then
    note_layout(r)
    local id = intern(to_identity(r, "cgroup_proc"))
    cache_put(exec_id, id, now)
    bump(counts, "cgroup_proc")
    return id, "cgroup_proc"
  end
  if why == "host" then
    local id = HOST
    cache_put(exec_id, id, now)
    bump(counts, "host_by_cgroup")
    return id, "host_by_cgroup"
  end

  local pc = cache_get(parent_exec_id(proc, parent), now)
  if pc and (pc.pod_uid or pc.container_id or pc.sensor_pod) then
    local id = { pod_uid = pc.pod_uid, pod_uid_form = pc.pod_uid_form, container_id = pc.container_id,
                 role = pc.role or "container", depth = pc.depth, relative = pc.relative, layout = pc.layout,
                 source = "chain", parent_pod = pc.sensor_pod }
    id = intern(id)
    cache_put(exec_id, id, now)
    bump(counts, "chain")
    return id, "chain"
  end
  if why == "no_exec_id" then why = "unattributed" end
  bump(counts, (why == "gone" and kind == "connect") and "gone_connect" or why)
  return nil, why
end

-- The containers parsed in this window whose cgroup has shown two or more distinct sub-cgroups (so far: a bounded
-- table of every container seen, wiped whole at MAX_CHILD_TRACK).
local function multi_child_now()
  local n = 0
  for cid in pairs(active) do
    local set = children[cid]
    if set ~= nil and set.n >= 2 then n = n + 1 end
  end
  return n
end

-- One association_health record (and the window's counters restart). node: NODE_NAME; extra: facts of the agent
-- (mode, cri, sensor_version).
function A.health(node, extra, now)
  local rec = { node = node, window_seconds = extra.window_seconds or 60, counts = counts, layout = layout,
                nested_depth = depth_hist, multi_child_container_cgroups = multi_child_now(), self_check = check,
                identities = A.cache_size(), mode = extra.mode, cri = extra.cri, sensor_version = extra.sensor_version,
                contract = 2 }
  counts, layout, depth_hist, active = {}, {}, {}, {}
  check = { checked = 0, agree = 0, disagree = 0 }
  return rec
end

return A
