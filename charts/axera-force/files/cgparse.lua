-- cgparse.lua: cgroup path -> pod UID / container id / role. Product-independent: the answer
-- rests on the cgroup path, the pod UID and the 64-hex container id only; runtime prefixes only label it.
-- Lua 5.1 / LuaJIT (the shipper) / Lua 5.4 compatible: plain patterns only, no goto, no utf8, no integer division.
local M = {}

local function is_hex(s, n)
  if n and #s ~= n then return false end
  return #s > 0 and s:find("^[0-9a-f]+$") ~= nil
end

local function pod_uid(tok)
  if #tok == 32 and is_hex(tok) then return tok, "config-hash" end
  if #tok ~= 36 then return nil end
  local a, b, c, d, e = tok:match("^(%x%x%x%x%x%x%x%x)[-_](%x%x%x%x)[-_](%x%x%x%x)[-_](%x%x%x%x)[-_](%x%x%x%x%x%x%x%x%x%x%x%x)$")
  if not a then return nil end
  local u = a .. "-" .. b .. "-" .. c .. "-" .. d .. "-" .. e
  if not is_hex((u:gsub("-", ""))) then return nil end
  return u, "uuid"
end

local function parse_pod(seg)
  if seg:sub(-6) == ".slice" then
    local body = seg:sub(1, -7)
    local i, last = 1, nil
    while true do
      local s = body:find("-pod", i, true)
      if not s then break end
      last, i = s, s + 1
    end
    if not last then return nil end
    local u, f = pod_uid(body:sub(last + 4))
    if u then return u, f, body:sub(1, last - 1) end
    return nil
  end
  if seg:sub(1, 3) == "pod" then
    local u, f = pod_uid(seg:sub(4))
    if u then return u, f, "" end
  end
  return nil
end

-- Output labels only: they never change the pod, the container or the role.
local LABEL = {
  ["crio"] = "cri-o", ["crio-conmon"] = "cri-o", ["cri-containerd"] = "containerd", ["docker"] = "docker",
  ["libpod"] = "podman", ["libpod-conmon"] = "podman", ["kata"] = "kata",
}

-- A container segment: "<anything>-<64 hex>.scope" (systemd), "<64 hex>" or "<anything>[-_]<64 hex>" (cgroupfs).
-- Returns id, runtime label (or nil), driver.
local function parse_container(seg)
  if seg:sub(-6) == ".scope" then
    local body = seg:sub(1, -7)
    if #body < 66 or body:sub(-65, -65) ~= "-" or not is_hex(body:sub(-64), 64) then return nil end
    return body:sub(-64), LABEL[body:sub(1, -66)], "systemd"
  end
  if is_hex(seg, 64) then return seg, nil, "cgroupfs" end
  if #seg >= 66 and is_hex(seg:sub(-64), 64) then
    local sep = seg:sub(-65, -65)
    if sep == "-" or sep == "_" then return seg:sub(-64), LABEL[seg:sub(1, -66)], "cgroupfs" end
  end
  return nil
end

local function strip_prefix(line)
  local id, rest = line:match("^(%d+):[^:]*:(.*)$")
  if id then return rest end
  return line
end

-- One cgroup line or path -> table or nil (a host cgroup).
function M.parse(line)
  if type(line) ~= "string" then return nil end
  local p = strip_prefix((line:gsub("^%s+", ""):gsub("%s+$", ""))):lower()
  local segs, rel = {}, false
  for s in p:gmatch("[^/]+") do
    if s == ".." then rel = true elseif s ~= "." then segs[#segs + 1] = s end
  end
  local r = { relative = rel, depthBelowContainer = 0 }
  -- The outermost pod segment: the node's kubelet made it. A deeper one belongs to a kubelet running inside that
  -- pod (kind / k3d / a nested cluster's CI runner), whose pods the node's pod list never holds.
  local pod_idx, pod_prefix = nil, ""
  for i = 1, #segs do
    local u, f, pre = parse_pod(segs[i])
    if u then r.podUid, r.podUidForm, pod_prefix, pod_idx = u, f, pre, i; break end
  end
  local c_idx
  if pod_idx then
    for i = pod_idx + 1, #segs do if parse_container(segs[i]) then c_idx = i; break end end
  else
    for i = #segs, 1, -1 do if parse_container(segs[i]) then c_idx = i; break end end
  end
  if c_idx then
    r.containerId, r.runtime, r.driver = parse_container(segs[c_idx])
    if r.runtime == nil and is_hex(segs[c_idx], 64) and c_idx > 1 and segs[c_idx - 1] == "docker" then r.runtime = "docker" end
    r.role = "container"
    r.depthBelowContainer = #segs - c_idx
    r.child = segs[c_idx + 1] -- the first sub-cgroup below the container (health only: multi-child layouts)
  elseif pod_idx then
    r.role = pod_idx == #segs and "pod" or "pod_aux"
    r.driver = segs[pod_idx]:sub(-6) == ".slice" and "systemd" or "cgroupfs"
  else
    return nil
  end
  if pod_idx then
    local parent = pod_idx > 1 and segs[pod_idx - 1] or ""
    if pod_prefix:find("besteffort", 1, true) or parent == "besteffort" then r.qos = "besteffort"
    elseif pod_prefix:find("burstable", 1, true) or parent == "burstable" then r.qos = "burstable"
    elseif parent == "kubepods" or parent == "kubepods.slice" or parent:sub(-15) == "-kubepods.slice" then r.qos = "guaranteed" end
  end
  return r
end

-- A whole /proc/<pid>/cgroup -> the most specific answer (pod+container > container > pod; ties: 0::, name=systemd, first).
function M.parse_proc_cgroup(content)
  if type(content) ~= "string" then return nil end
  local best, best_score, best_rank = nil, 0, 99
  for line in content:gmatch("[^\n]+") do
    local r = M.parse(line)
    if r then
      local rank = 2
      if line:sub(1, 3) == "0::" then rank = 0 elseif line:find(":name=systemd:", 1, true) then rank = 1 end
      local score = (r.podUid and 1 or 0) + (r.containerId and 2 or 0)
      if score > best_score or (score == best_score and rank < best_rank) then best, best_score, best_rank = r, score, rank end
    end
  end
  return best
end

-- The layout class of an answer (health only): relative | cgroupfs | flat | nested.
function M.layout(r)
  if not r then return "unknown" end
  if r.relative then return "relative" end
  if r.driver == "cgroupfs" then return "cgroupfs" end
  if (r.depthBelowContainer or 0) > 0 then return "nested" end
  return "flat"
end

return M
