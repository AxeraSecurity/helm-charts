{{/* =========================================================================================
     Labels
     ========================================================================================= */}}

{{/* Standard labels for one component. Context: (list $ "<component>"). */}}
{{- define "axeraforce.labelsFor" -}}
{{- $ctx := index . 0 -}}
app.kubernetes.io/name: {{ $ctx.Chart.Name }}
app.kubernetes.io/instance: {{ $ctx.Release.Name }}
app.kubernetes.io/component: {{ index . 1 }}
app.kubernetes.io/version: {{ $ctx.Chart.AppVersion | quote }}
app.kubernetes.io/part-of: axera
app.kubernetes.io/managed-by: {{ $ctx.Release.Service }}
helm.sh/chart: {{ printf "%s-%s" $ctx.Chart.Name $ctx.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "axeraforce.labels" -}}
{{- include "axeraforce.labelsFor" (list . "agent") -}}
{{- end }}

{{/* Extra pod-template labels: stable ones only (no version, no chart), so a chart bump rolls no pod.
     The selector stays app: axera-agent alone (the Axera API finds the capture sidecar by it). */}}
{{- define "axeraforce.podLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: agent
{{- end }}

{{/* =========================================================================================
     Topics and Kafka
     ========================================================================================= */}}

{{/* The flow topic is the cluster's name (flow.topic may only repeat clusterName, see the guards), and the
     process and DNS topics follow it: Axera derives <c>-process and <c>-dns from the registered name. */}}
{{- define "axeraforce.flowTopic" -}}
{{- .Values.flow.topic | default .Values.clusterName -}}
{{- end }}

{{- define "axeraforce.dnsTopic" -}}
{{- .Values.flow.dnsTopic | default (printf "%s-dns" (include "axeraforce.flowTopic" .)) -}}
{{- end }}

{{- define "axeraforce.processTopic" -}}
{{- .Values.process.topic | default (printf "%s-process" (include "axeraforce.flowTopic" .)) -}}
{{- end }}

{{- define "axeraforce.tls" -}}
{{- if or (eq .Values.kafka.securityProtocol "Ssl") (eq .Values.kafka.securityProtocol "SaslSsl") -}}true{{- end -}}
{{- end }}

{{- define "axeraforce.sasl" -}}
{{- if or (eq .Values.kafka.securityProtocol "SaslSsl") (eq .Values.kafka.securityProtocol "SaslPlaintext") -}}true{{- end -}}
{{- end }}

{{/* "true" when the writers verify the broker against a mounted CA (Secret kafka-ca, key ca.crt): TLS is on,
     verification is on, and the broker is not trusted through the images' system store
     (kafka.systemTrustStore). The CA comes from inline kafka.caCert (createSecret true; the guards refuse
     createSecret true without it) or a pre-created kafka-ca (createSecret false). ONE definition for the
     DaemonSet mounts, the flow pipeline's caCertPath and the shipper's ssl.ca.location, so the three never
     disagree. */}}
{{- define "axeraforce.useCA" -}}
{{- $k := .Values.kafka -}}
{{- if and (include "axeraforce.tls" .) (not $k.insecureSkipVerify) (not $k.systemTrustStore) -}}true{{- end -}}
{{- end }}

{{/* The flow pipeline's SASL type spelling. Its Kafka writer knows only plain and SCRAM-SHA-512, so
     ScramSha256 fails the render instead of shipping a flow writer that can never log in. */}}
{{- define "axeraforce.flpSaslType" -}}
{{- $m := .Values.kafka.saslMechanism -}}
{{- if eq $m "ScramSha512" -}}scramSHA512
{{- else if eq $m "ScramSha256" -}}
{{- fail "kafka.saslMechanism ScramSha256 is not supported: the agent's flow pipeline can log in only with Plain or SCRAM-SHA-512, so no flows would ever reach Axera. Give the agent's Kafka user a SCRAM-SHA-512 credential and set kafka.saslMechanism: ScramSha512." -}}
{{- else -}}plain
{{- end -}}
{{- end }}

{{/* The ONE broker address the flow pipeline's Kafka writers get. That writer takes a single address and
     stops at start on a comma-separated list, so kafka.bootstrapServers is cut to its first non-empty
     entry; the other brokers come from that broker's metadata. The shipper keeps the whole list. */}}
{{- define "axeraforce.flpKafkaAddress" -}}
{{- $addr := "" -}}
{{- range splitList "," .Values.kafka.bootstrapServers -}}
{{- if and (not $addr) (trim .) -}}{{- $addr = trim . -}}{{- end -}}
{{- end -}}
{{- if not $addr -}}
{{- fail (printf "kafka.bootstrapServers %q names no broker: give host:port, or a comma-separated host:port list" .Values.kafka.bootstrapServers) -}}
{{- end -}}
{{- $addr | quote -}}
{{- end }}

{{/* flow.ingress.enabled as "true" / "". `dig` keeps an explicit false, and a missing flow.ingress map
     cannot nil-pointer the render. */}}
{{- define "axeraforce.ingress" -}}
{{- if eq (toString (dig "ingress" "enabled" false (.Values.flow | default dict))) "true" -}}true{{- end -}}
{{- end }}

{{- define "axeraforce.ingressTopic" -}}
{{- dig "ingress" "topic" "" (.Values.flow | default dict) | default "ingress-flows" -}}
{{- end }}

{{/* Why the flow pipeline image (the context, a string) cannot run the ingress lane, or "" when it can. The
     lane's keep-entry query uses with()/without() (v1.9.0 or later); an older image refuses the query at
     start, on every node. The legacy Axera build of the pipeline (tag v1) never ran the query and is
     refused too. Any other tag, or a digest-only reference, renders. */}}
{{- define "axeraforce.flpIngressProblem" -}}
{{- $img := toString . -}}
{{- if regexMatch "(^|/)axera-flowlogs-pipeline:v1(@|$)" $img -}}
is the legacy Axera flow pipeline build, which does not support the ingress query
{{- else -}}
{{- $ver := regexFind "(^|/)flowlogs-pipeline:v?[0-9]+[.][0-9]+" $img | regexFind "[0-9]+[.][0-9]+$" -}}
{{- if $ver -}}
{{- $maj := atoi (first (splitList "." $ver)) -}}
{{- $min := atoi (last (splitList "." $ver)) -}}
{{- if or (lt $maj 1) (and (eq $maj 1) (lt $min 9)) -}}
is version {{ $ver }}, older than v1.9.0
{{- end -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* The shipper's rdkafka.security.protocol. */}}
{{- define "axeraforce.fbSecurityProtocol" -}}
{{- $p := .Values.kafka.securityProtocol -}}
{{- if eq $p "Ssl" -}}ssl
{{- else if eq $p "SaslSsl" -}}sasl_ssl
{{- else if eq $p "SaslPlaintext" -}}sasl_plaintext
{{- else -}}plaintext
{{- end -}}
{{- end }}

{{/* The shipper's rdkafka.sasl.mechanisms spelling. */}}
{{- define "axeraforce.fbSaslMechanism" -}}
{{- $m := .Values.kafka.saslMechanism -}}
{{- if eq $m "ScramSha512" -}}SCRAM-SHA-512
{{- else if eq $m "ScramSha256" -}}SCRAM-SHA-256
{{- else -}}PLAIN
{{- end -}}
{{- end }}

{{/* One container's resources block as JSON, for `with ... | fromJson`: resources.<key> when set and
     non-empty (it REPLACES the default whole: requests and limits are never merged), else
     resourceDefaults.<key>, else {} (no resources block). Call: include "axeraforce.resources" (list . "flowPipeline"). */}}
{{- define "axeraforce.resources" -}}
{{- $ctx := index . 0 -}}
{{- $key := index . 1 -}}
{{- dig $key dict ($ctx.Values.resources | default dict) | default (dig $key dict ($ctx.Values.resourceDefaults | default dict)) | toJson -}}
{{- end }}

{{/* checksum/kafka-secret: rolls the pods when the Kafka Secrets they read change. The shipper takes
     the SASL credentials from env and the flow pipeline reads the mounted files and CA at start, so a
     rotated password or CA reaches the agent only through a rollout. createSecret: a hash of the data of
     the Secrets 10-secrets.yaml renders (the values file already holds those credentials).
     Bring-your-own: a hash of the metadata.uid and metadata.resourceVersion of the Secrets the DaemonSet
     references (kafka-ca while it mounts a CA, kafka-sasl under SASL), looked up at install/upgrade
     time, never of their data: the annotation is readable by whoever can read the DaemonSet, so no
     credential material goes into it. Any write to such a Secret changes its resourceVersion, so the
     next helm upgrade rolls the pods. That includes writes that leave the data as it was: a
     controller touching labels or annotations, a storage-version migration, or the re-encryption
     that follows an etcd encryption key rotation (on OpenShift with etcd encryption, weekly). The
     first helm upgrade after one of those rolls the agent once without a credential change; hashing
     the data instead would put a value derived from the credentials into the annotation. A missing
     Secret hashes as empty and never fails the render.
     `helm template` and GitOps renders cannot look them up, so they always hash as empty there: after
     rotating a bring-your-own Secret, run `kubectl -n axera rollout restart daemonset/axera-agent`. */}}
{{- define "axeraforce.kafkaSecretChecksum" -}}
{{- if .Values.kafka.createSecret -}}
{{- include "axeraforce.dataChecksum" (list . "10-secrets.yaml") -}}
{{- else -}}
{{- $names := list -}}
{{- if include "axeraforce.useCA" . -}}{{- $names = append $names "kafka-ca" -}}{{- end -}}
{{- if include "axeraforce.sasl" . -}}{{- $names = append $names "kafka-sasl" -}}{{- end -}}
{{- $ids := dict -}}
{{- range $name := $names -}}
{{- $m := (lookup "v1" "Secret" $.Release.Namespace $name).metadata | default dict -}}
{{- $_ := set $ids $name (printf "%s/%s" (toString ($m.uid | default "")) (toString ($m.resourceVersion | default ""))) -}}
{{- end -}}
{{- toJson $ids | sha256sum -}}
{{- end -}}
{{- end }}

{{/* sha256 of what the pods read from the objects one template renders: the data, binaryData and
     stringData of each, keyed by kind/name. Labels and the rest of the metadata are left out (helm.sh/chart
     carries the chart version), so a chart-version bump rolls no pod while any change to the rendered
     content still does. The context is (list $ "<file under templates/>"). */}}
{{- define "axeraforce.dataChecksum" -}}
{{- $ctx := index . 0 -}}
{{- $file := index . 1 -}}
{{- $data := dict -}}
{{- range $doc := regexSplit "(?m)^---[ \\t]*$" (include (print $ctx.Template.BasePath "/" $file) $ctx) -1 -}}
{{- $obj := fromYaml $doc -}}
{{- if hasKey $obj "Error" -}}
{{- fail (printf "axeraforce.dataChecksum: %s does not parse: %s" $file (get $obj "Error")) -}}
{{- end -}}
{{- with $obj -}}
{{- $_ := set $data (printf "%s/%s" (get . "kind") (dig "metadata" "name" "" .)) (pick . "data" "binaryData" "stringData") -}}
{{- end -}}
{{- end -}}
{{- toJson $data | sha256sum -}}
{{- end }}

{{/* The producer codec kafka.compression names: none | gzip | snappy | lz4 | zstd, unset = lz4. */}}
{{- define "axeraforce.kafkaCompression" -}}
{{- $codec := .Values.kafka.compression | default "lz4" -}}
{{- if not (has $codec (list "none" "gzip" "snappy" "lz4" "zstd")) -}}
{{- fail (printf "kafka.compression %q is not one of none, gzip, snappy, lz4, zstd" $codec) -}}
{{- end -}}
{{- $codec -}}
{{- end }}

{{/* Why the flow pipeline image (the context, a string) cannot take a Kafka compression setting, or "" when it
     can. The pipeline parses its config strictly and knows the field from v1.11.4 on, so an older image
     refuses the whole config at start. The legacy Axera build of the pipeline (tag v1) predates the field
     and is refused too. Any other tag, or a digest-only reference, renders. */}}
{{- define "axeraforce.flpCompressionProblem" -}}
{{- $img := toString . -}}
{{- if regexMatch "(^|/)axera-flowlogs-pipeline:v1(@|$)" $img -}}
is the legacy Axera flow pipeline build, which does not know the compression setting
{{- else -}}
{{- $ver := regexFind "(^|/)flowlogs-pipeline:v?[0-9]+[.][0-9]+([.][0-9]+)?" $img | regexFind "[0-9]+[.][0-9]+([.][0-9]+)?$" -}}
{{- if $ver -}}
{{- $parts := splitList "." $ver -}}
{{- $maj := atoi (index $parts 0) -}}
{{- $min := atoi (index $parts 1) -}}
{{- $patch := 0 -}}
{{- if gt (len $parts) 2 }}{{ $patch = atoi (index $parts 2) }}{{ end -}}
{{- if or (lt $maj 1) (and (eq $maj 1) (or (lt $min 11) (and (eq $min 11) (lt $patch 4)))) -}}
is version {{ $ver }}, older than v1.11.4
{{- end -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* The compression of every flow pipeline Kafka writer, or "" to leave the key out. none is the
     pipeline's own default and is left out. An image that does not know the field keeps its writers
     uncompressed when kafka.compression is unset, and fails the render when a codec is asked for. */}}
{{- define "axeraforce.flpCompression" -}}
{{- $codec := include "axeraforce.kafkaCompression" . -}}
{{- if ne $codec "none" -}}
{{- $img := toString (.Values.images).flowPipeline -}}
{{- $problem := include "axeraforce.flpCompressionProblem" $img -}}
{{- if not $problem -}}
{{- $codec -}}
{{- else if .Values.kafka.compression -}}
{{- fail (printf "kafka.compression %s needs a flow pipeline image v1.11.4 or later, and images.flowPipeline %q %s (it would refuse its config at start, on every node). Use the chart's default images.flowPipeline, or leave kafka.compression unset (or none)." $codec $img $problem) -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* =========================================================================================
     Process sensor and shipper
     ========================================================================================= */}}

{{/* process.observe / dedupeWindowSeconds. Application namespaces only by default: host processes,
     openshift / openshift-* and kube-* are opt-in. */}}
{{- define "axeraforce.processObserve" -}}
{{- $o := (.Values.process).observe | default dict -}}
{{- toJson (dict
  "hostProcesses" (dig "hostProcesses" false $o)
  "openshiftNamespaces" (dig "openshiftNamespaces" false $o)
  "kubeNamespaces" (dig "kubeNamespaces" false $o)
  "excludeNamespaces" (dig "excludeNamespaces" (list) $o)
  "execFollowsScope" (dig "execFollowsScope" true $o)) -}}
{{- end }}

{{/* The dedupe window in seconds; an explicit 0 is kept (default would read it as unset). */}}
{{- define "axeraforce.processDedupeWindow" -}}
{{- $p := .Values.process | default dict -}}
{{- if hasKey $p "dedupeWindowSeconds" }}{{ $p.dedupeWindowSeconds | int }}{{ else }}60{{ end -}}
{{- end }}

{{/* The sensor's export-denylist regexes for the namespaces whose connects are not shipped (PROCESS_KPROBE
     only). Empty when every namespace is observed. A pod-less (host) event never matches namespace_regex. */}}
{{- define "axeraforce.processNamespaceDenyRegex" -}}
{{- $o := include "axeraforce.processObserve" . | fromJson -}}
{{- $re := list -}}
{{- if not $o.openshiftNamespaces }}{{ $re = append $re "^openshift$" }}{{ $re = append $re "^openshift-" }}{{ end -}}
{{- if not $o.kubeNamespaces }}{{ $re = append $re "^kube-" }}{{ end -}}
{{- range $o.excludeNamespaces }}
{{- if hasSuffix "*" . }}{{ $re = append $re (printf "^%s" (trimSuffix "*" .)) }}{{ else }}{{ $re = append $re (printf "^%s$" .) }}{{ end -}}
{{- end -}}
{{- toJson (uniq $re) -}}
{{- end }}

{{/* The process-to-pod association as JSON: mode ("shadow" | "on"; shadow unless process.association.mode is
     exactly "on") and the CRI socket hint's state as rendered ("off" | "configured" | "invalid"; the shipper
     turns "configured" into the node's own answer, "present" or "missing", see axeraforce.criHint). */}}
{{- define "axeraforce.processAssociation" -}}
{{- $a := (.Values.process).association | default dict -}}
{{- $mode := "shadow" -}}
{{- if eq (toString (dig "mode" "shadow" $a)) "on" }}{{ $mode = "on" }}{{ end -}}
{{- toJson (dict "mode" $mode "cri" (include "axeraforce.criHint" . | fromJson).state) -}}
{{- end }}

{{/* The CRI socket hint in effect: process.criSocket when set ("none" switches the distribution's hint off),
     else the distribution's usual containerd socket (k3s and RKE2: /run/k3s/containerd/containerd.sock;
     Anthos: /run/containerd/containerd.sock; OpenShift and vanilla: none). Only a hint: the sensor checks
     it on each node at start, and a missing socket never blocks the agent. */}}
{{- define "axeraforce.criSocket" -}}
{{- $s := trim (toString ((.Values.process).criSocket | default "")) -}}
{{- if eq $s "none" -}}
{{- else if $s -}}{{ $s }}
{{- else -}}
{{- $d := (include "axeraforce.distribution" . | fromJson).name -}}
{{- if has $d (list "k3s" "rke2") }}/run/k3s/containerd/containerd.sock{{ else if eq $d "anthos" }}/run/containerd/containerd.sock{{ end -}}
{{- end -}}
{{- end }}

{{/* The CRI socket hint as JSON: state "off" (none), "invalid" (the path the sensor would dial,
     /procRoot/1/root<path>, is over the 107-byte unix socket path limit: the hint is ignored and reported, never
     a failed render) or "configured"; path, the endpoint through the host's root as the host's PID 1 sees it
     (/procRoot is the host's /proc, already mounted: no hostPath of type Socket, so a missing, moved or proxied
     socket never keeps the agent pod in ContainerCreating); cgidmap, whether the sensor's cgroup id map is
     switched on with it (never with a TracingPolicy podSelector). The sensor container decides per node at
     start whether to use it at all (30-daemonset.yaml). */}}
{{- define "axeraforce.criHint" -}}
{{- $s := include "axeraforce.criSocket" . -}}
{{- $p := printf "/procRoot/1/root%s" $s -}}
{{- $state := "off" -}}
{{- if $s }}{{ $state = ternary "invalid" "configured" (gt (len $p) 107) }}{{ end -}}
{{- $on := eq $state "configured" -}}
{{- toJson (dict "state" $state "path" (ternary $p "" $on) "cgidmap" (and $on (not (.Values.process).tracingPolicyPodSelector))) -}}
{{- end }}

{{/* The sensor image's version, the only part of the image reference the association health reports: the tag
     (a digest shortened to its first 12 hex), never the registry or repository. "" when it has neither. */}}
{{- define "axeraforce.sensorVersion" -}}
{{- include "axeraforce.imageVersion" .Values.images.processSensor -}}
{{- end }}

{{/* The version part of an image reference: its tag, else a digest shortened to "sha256:<12 hex>", else "". */}}
{{- define "axeraforce.imageVersion" -}}
{{- $ref := toString . -}}
{{- $pre := first (splitList "@" $ref) -}}
{{- $last := last (splitList "/" $pre) -}}
{{- if contains ":" $last }}{{ last (splitList ":" $last) }}{{ else if contains "@" $ref }}{{ trunc 19 (last (splitList "@" $ref)) }}{{ end -}}
{{- end }}

{{/* The agent's metrics endpoints as JSON: enabled, and one NODE port each. The sensor keeps
     process.metricsPort when that is set; with metrics off only that endpoint stays. */}}
{{- define "axeraforce.metrics" -}}
{{- $m := .Values.metrics | default dict -}}
{{- $on := ne (toString (dig "enabled" true $m)) "false" -}}
{{- $sensor := (.Values.process).metricsPort | default (dig "sensorPort" 28083 $m) -}}
{{- toJson (dict
  "enabled" $on
  "flowAgentPort" (dig "flowAgentPort" 28081 $m | int)
  "flowPipelinePort" (dig "flowPipelinePort" 28082 $m | int)
  "sensorPort" ($sensor | int)
  "shipperPort" (dig "shipperPort" 28084 $m | int)) -}}
{{- end }}

{{/* =========================================================================================
     Distribution and platform
     ========================================================================================= */}}

{{/* The distribution, as JSON {"name", "how", "requested"}. global.distribution names it (how "set"), or
     auto detects it (how "detected"): OpenShift when the API server serves security.openshift.io/v1 or
     route.openshift.io/v1; else a lookup of the Nodes, where a kubelet version containing "+k3s" means k3s,
     "+rke2" RKE2 and "-gke." Anthos (GKE on-prem); else vanilla. When auto cannot see the cluster at all
     (helm template, a GitOps render) it falls back to vanilla with how "fallback", and NOTES says to set
     global.distribution. Read once per render: the answer is kept in .Values._axeraforceDistribution, which
     every template of this render shares, so no two objects are rendered from two different answers. */}}
{{- define "axeraforce.distribution" -}}
{{- if not (hasKey .Values "_axeraforceDistribution") -}}
{{- $want := toString ((.Values.global).distribution | default "auto") -}}
{{- if not (has $want (list "auto" "openshift" "k3s" "rke2" "anthos" "vanilla")) -}}
{{- fail (printf "global.distribution must be one of auto, openshift, k3s, rke2, anthos, vanilla, not %q" $want) -}}
{{- end -}}
{{- $name := $want -}}
{{- $how := "set" -}}
{{- if eq $want "auto" -}}
{{- $how = "detected" -}}
{{- if or (.Capabilities.APIVersions.Has "security.openshift.io/v1") (.Capabilities.APIVersions.Has "route.openshift.io/v1") -}}
{{- $name = "openshift" -}}
{{- else -}}
{{- $name = "" -}}
{{- $nodes := (lookup "v1" "Node" "" "").items | default list -}}
{{- range $nodes -}}
{{- $kv := toString (dig "status" "nodeInfo" "kubeletVersion" "" .) -}}
{{- if not $name -}}
{{- if contains "+k3s" $kv }}{{ $name = "k3s" }}{{ else if contains "+rke2" $kv }}{{ $name = "rke2" }}{{ else if contains "-gke." $kv }}{{ $name = "anthos" }}{{ end -}}
{{- end -}}
{{- end -}}
{{- if not $name -}}
{{- $name = "vanilla" -}}
{{- if not $nodes }}{{ $how = "fallback" }}{{ end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- $_ := set .Values "_axeraforceDistribution" (dict "name" $name "how" $how "requested" $want) -}}
{{- end -}}
{{- toJson .Values._axeraforceDistribution -}}
{{- end }}

{{/* The platform, as JSON {"distribution", "openshift", "networkType", "clusterNetworks", "serviceNetworks",
     "nodeSeesPodTraffic"}.
     openshift: the distribution is openshift. networkType: the Network "cluster" object's status.networkType
     (else spec.networkType), read only on a live OpenShift install. clusterNetworks / serviceNetworks: the
     IPv4 entries of the same object's status.clusterNetwork[].cidr and status.serviceNetwork (else spec),
     empty when it cannot be read. nodeSeesPodTraffic: OVNKubernetes or
     OpenShiftSDN, whose datapath carries every pod's traffic through the node's interfaces. On OpenShift a
     network type that cannot be read (helm template, a GitOps render) counts as OVN-Kubernetes, the OpenShift
     default, so an offline render matches a live install; any other plugin, and every other distribution,
     counts as false. A REFUSED read (403, 5xx) is not "unknown": Helm's lookup turns only NotFound into an
     empty answer, so the render fails rather than guess. Memoised in .Values._axeraforcePlatform. */}}
{{- define "axeraforce.platform" -}}
{{- if not (hasKey .Values "_axeraforcePlatform") -}}
{{- $d := (include "axeraforce.distribution" . | fromJson).name -}}
{{- $os := eq $d "openshift" -}}
{{- $type := "" -}}
{{- $cn := list -}}
{{- $sn := list -}}
{{- if and $os (.Capabilities.APIVersions.Has "config.openshift.io/v1/Network") -}}
{{- $n := lookup "config.openshift.io/v1" "Network" "" "cluster" | default dict -}}
{{- $type = dig "status" "networkType" (dig "spec" "networkType" "" $n) $n | toString -}}
{{- $re := include "axeraforce.cidrRegex" . -}}
{{- range (dig "status" "clusterNetwork" list $n | default (dig "spec" "clusterNetwork" list $n)) -}}
{{- $c := "" -}}
{{- if kindIs "map" . }}{{ $c = toString (dig "cidr" "" .) }}{{ end -}}
{{- if regexMatch $re $c }}{{ $cn = append $cn $c }}{{ end -}}
{{- end -}}
{{- range (dig "status" "serviceNetwork" list $n | default (dig "spec" "serviceNetwork" list $n)) -}}
{{- if regexMatch $re (toString .) }}{{ $sn = append $sn (toString .) }}{{ end -}}
{{- end -}}
{{- end -}}
{{- $sees := false -}}
{{- if $os }}{{ $sees = or (eq $type "") (has $type (list "OVNKubernetes" "OpenShiftSDN")) }}{{ end -}}
{{- $_ := set .Values "_axeraforcePlatform" (dict "distribution" $d "openshift" $os "networkType" $type "clusterNetworks" ($cn | uniq) "serviceNetworks" ($sn | uniq) "nodeSeesPodTraffic" $sees) -}}
{{- end -}}
{{- toJson .Values._axeraforcePlatform -}}
{{- end }}

{{/* Pod network namespace access, as JSON {"flow": bool, "capture": bool}: flow.podNetnsAttach (the flow
     agent attaches inside every pod's netns: CAP_SYS_ADMIN + /var/run/netns) and capture.podNetns (the
     capture sidecar enters the source pod's netns: CAP_SYS_ADMIN + CAP_SYS_PTRACE). An explicit true or
     false wins; unset follows the platform: off where the node's interfaces carry every pod's traffic
     (OpenShift on OVN-Kubernetes or OpenShiftSDN), on everywhere else (k3s, RKE2, Anthos, vanilla). */}}
{{- define "axeraforce.podNetns" -}}
{{- $offByDefault := (include "axeraforce.platform" . | fromJson).nodeSeesPodTraffic -}}
{{- $f := (.Values.flow).podNetnsAttach -}}
{{- $c := (.Values.capture).podNetns -}}
{{- toJson (dict "flow" (ternary $f (not $offByDefault) (kindIs "bool" $f)) "capture" (ternary $c (not $offByDefault) (kindIs "bool" $c))) -}}
{{- end }}

{{/* "true" when the OpenShift SCC and its use-Role render: createSCC true, or auto on OpenShift. */}}
{{- define "axeraforce.createSCC" -}}
{{- $c := .Values.createSCC -}}
{{- if kindIs "bool" $c -}}
{{- if $c -}}true{{- end -}}
{{- else -}}
{{- $s := toString ($c | default "auto") -}}
{{- if eq $s "true" -}}true
{{- else if eq $s "auto" -}}
{{- if (include "axeraforce.platform" . | fromJson).openshift -}}true{{- end -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* "true" when AppArmor is set through securityContext.appArmorProfile (Kubernetes 1.30 and later) instead of
     the older per-container annotation. Only used off OpenShift. */}}
{{- define "axeraforce.appArmorField" -}}
{{- if semverCompare ">=1.30.0-0" .Capabilities.KubeVersion.Version -}}true{{- end -}}
{{- end }}

{{/* The pod ranges the k3s / RKE2 nodes were handed (spec.podCIDR, IPv4 only), as a JSON list of
     [node, cidr]. Read once, on a live install only (helm template sees no Node: empty). */}}
{{- define "axeraforce.nodePodCIDRs" -}}
{{- if not (hasKey .Values "_axeraforceNodePodCIDRs") -}}
{{- $re := include "axeraforce.cidrRegex" . -}}
{{- $l := list -}}
{{- range ((lookup "v1" "Node" "" "").items | default list) -}}
{{- $c := toString (dig "spec" "podCIDR" "" .) -}}
{{- if regexMatch $re $c }}{{ $l = append $l (list (toString (dig "metadata" "name" "" .)) $c) }}{{ end -}}
{{- end -}}
{{- $_ := set .Values "_axeraforceNodePodCIDRs" $l -}}
{{- end -}}
{{- toJson .Values._axeraforceNodePodCIDRs -}}
{{- end }}

{{/* The pod network CIDR in effect, never a silent guess. podCIDR when set. Else, on a live OpenShift install,
     the first entry of the Network "cluster" object's clusterNetwork (an explicit podCIDR must be one of
     those entries). Else, on a live k3s / RKE2 install whose nodes carry pod ranges, the k3s / RKE2 default
     10.42.0.0/16 (the guards then check that every node's pod range lies inside the pod ranges). Anything
     else (an offline render, Anthos, vanilla) needs podCIDR. */}}
{{- define "axeraforce.podCIDR" -}}
{{- $v := trim (toString (.Values.podCIDR | default "")) -}}
{{- $d := include "axeraforce.distribution" . | fromJson -}}
{{- $nets := (include "axeraforce.platform" . | fromJson).clusterNetworks | default list -}}
{{- if $nets -}}
{{- if not $v }}{{ $v = first $nets }}{{ end -}}
{{- if not (has $v $nets) -}}
{{- fail (printf "\n\npodCIDR %s is not one of this cluster's pod networks %s (Network cluster, status.clusterNetwork). Set podCIDR to one of them, or leave it empty to read it from the cluster." $v (join ", " $nets)) -}}
{{- end -}}
{{- else if and (not $v) (has $d.name (list "k3s" "rke2")) (include "axeraforce.nodePodCIDRs" . | fromJsonArray) -}}
{{- $v = "10.42.0.0/16" -}}
{{- end -}}
{{- if not $v -}}
{{- $hint := "kubeadm sets it with --pod-network-cidr; with Calico it is often 192.168.0.0/16, with Flannel 10.244.0.0/16" -}}
{{- if eq $d.name "anthos" }}{{ $hint = "read it from the user cluster configuration (GKE on VMware: network.podCIDR; bare metal: clusterNetwork.pods.cidrBlocks; the usual default is 192.168.0.0/16)" }}{{ end -}}
{{- if eq $d.name "openshift" }}{{ $hint = "this render cannot read the cluster's Network object (helm template, a GitOps render). The usual value is 10.128.0.0/14; check it with: oc get network.config cluster -o jsonpath='{.status.clusterNetwork}'" }}{{ end -}}
{{- if has $d.name (list "k3s" "rke2") }}{{ $hint = printf "this render cannot see the nodes' pod ranges (helm template, a GitOps render). The usual value is 10.42.0.0/16; check cluster-cidr in /etc/rancher/%s/config.yaml (or the server's --cluster-cidr), or: kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}'" $d.name }}{{ end -}}
{{- $why := "" -}}
{{- if eq $d.how "fallback" }}{{ $why = " (global.distribution is auto, but this render cannot see the cluster, for example helm template or a GitOps tool, so it fell back to vanilla: set global.distribution explicitly)" }}{{ end -}}
{{- fail (printf "\n\npodCIDR is required on distribution %q%s: %s. Set podCIDR to this cluster's pod network CIDR (a wrong value silently empties or pollutes the external-flows lane)." $d.name $why $hint) -}}
{{- end -}}
{{- $v -}}
{{- end }}

{{/* Where the pod CIDR in effect came from, for NOTES: "set", "cluster" (read from the Network object) or
     "default" (the k3s / RKE2 default, checked against the nodes' pod ranges). */}}
{{- define "axeraforce.podCIDRSource" -}}
{{- if trim (toString (.Values.podCIDR | default "")) -}}set
{{- else if (include "axeraforce.platform" . | fromJson).clusterNetworks -}}cluster
{{- else -}}default
{{- end -}}
{{- end }}

{{/* The Service network CIDR in effect: serviceCIDR, else on a live OpenShift install the first entry of the
     Network object's serviceNetwork, else the distribution's default (OpenShift 172.30.0.0/16, k3s and RKE2
     10.43.0.0/16), else none. It joins the in-cluster ranges, so a ClusterIP counts as in-cluster. */}}
{{- define "axeraforce.serviceCIDR" -}}
{{- $v := trim (toString (.Values.serviceCIDR | default "")) -}}
{{- $svc := (include "axeraforce.platform" . | fromJson).serviceNetworks | default list -}}
{{- if $v -}}{{ $v }}
{{- else if $svc -}}{{ first $svc }}
{{- else -}}
{{- $d := (include "axeraforce.distribution" . | fromJson).name -}}
{{- if eq $d "openshift" }}172.30.0.0/16{{ else if has $d (list "k3s" "rke2") }}10.43.0.0/16{{ end -}}
{{- end -}}
{{- end }}

{{/* The pod ranges as a JSON list: the pod CIDR, the cluster's other pod networks (OpenShift, read live), then
     extraPodCIDRs. */}}
{{- define "axeraforce.podCIDRs" -}}
{{- $l := list (include "axeraforce.podCIDR" .) -}}
{{- $l = concat $l ((include "axeraforce.platform" . | fromJson).clusterNetworks | default list) -}}
{{- range (.Values.extraPodCIDRs | default list) }}{{ $l = append $l (toString .) }}{{ end -}}
{{- toJson ($l | compact | uniq) -}}
{{- end }}

{{/* The in-cluster ranges as a JSON list: the pod ranges, then the Service CIDR (and, on OpenShift, the
     cluster's other service networks). They label ClusterSubnet in the flow pipeline and feed the shipper's
     host-process rule. */}}
{{- define "axeraforce.clusterCIDRs" -}}
{{- $l := include "axeraforce.podCIDRs" . | fromJsonArray -}}
{{- $l = append $l (include "axeraforce.serviceCIDR" .) -}}
{{- $l = concat $l ((include "axeraforce.platform" . | fromJson).serviceNetworks | default list) -}}
{{- toJson ($l | compact | uniq) -}}
{{- end }}

{{/* flow.tcAttachMode in effect: the value when set, else tcx on Anthos (its eBPF datapath attaches TC
     programs that legacy TC mode would remove) and any everywhere else. */}}
{{- define "axeraforce.tcAttachMode" -}}
{{- $d := (include "axeraforce.distribution" . | fromJson).name -}}
{{- with (.Values.flow).tcAttachMode }}{{ toString . }}{{ else }}{{ ternary "tcx" "any" (eq $d "anthos") }}{{ end -}}
{{- end }}

{{/* The agent's nodeSelector: nodeSelector merged with kubernetes.io/os: linux (eBPF programs run on Linux
     only) and, with requireAmd64, kubernetes.io/arch: amd64 (the shipper and capture images are amd64-only).
     A key set in nodeSelector wins. */}}
{{- define "axeraforce.nodeSelector" -}}
{{- $base := dict "kubernetes.io/os" "linux" -}}
{{- if .Values.requireAmd64 }}{{ $_ := set $base "kubernetes.io/arch" "amd64" }}{{ end -}}
{{- toYaml (merge (deepCopy (.Values.nodeSelector | default dict)) $base) -}}
{{- end }}

{{/* imagePullSecrets accepts names ("x") or objects ({name: x}). */}}
{{- define "axeraforce.imagePullSecrets" -}}
{{- range .Values.imagePullSecrets }}
{{- if kindIs "string" . }}
- name: {{ . | quote }}
{{- else if .name }}
- name: {{ .name | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/* The host directory holding the API server's audit.log, for the audit forwarder: auditForwarder.logDir,
     else /var/log/kube-apiserver on OpenShift, else "" (required off OpenShift; see the guards). */}}
{{- define "axeraforce.auditLogDir" -}}
{{- $v := trim (toString ((.Values.auditForwarder).logDir | default "")) -}}
{{- if $v -}}{{ $v }}
{{- else if (include "axeraforce.platform" . | fromJson).openshift -}}/var/log/kube-apiserver
{{- end -}}
{{- end }}

{{/* =========================================================================================
     CIDR helpers
     ========================================================================================= */}}

{{- define "axeraforce.cidrRegex" -}}
^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/([0-9]|[12][0-9]|3[0-2])$
{{- end }}

{{/* IPv4 CIDR "a.b.c.d/n" -> "<address as integer> <n>". Input must already match the CIDR regex. */}}
{{- define "axeraforce.cidrParse" -}}
{{- $parts := splitList "/" . -}}
{{- $o := splitList "." (index $parts 0) -}}
{{- $ip := add (mul (atoi (index $o 0)) 16777216) (mul (atoi (index $o 1)) 65536) (mul (atoi (index $o 2)) 256) (atoi (index $o 3)) -}}
{{- printf "%d %s" (int64 $ip) (index $parts 1) -}}
{{- end }}

{{/* "true" when CIDR .inner lies entirely inside CIDR .outer, or equals it (both IPv4, already validated). */}}
{{- define "axeraforce.cidrInside" -}}
{{- $i := splitList " " (include "axeraforce.cidrParse" .inner) -}}
{{- $o := splitList " " (include "axeraforce.cidrParse" .outer) -}}
{{- $iLen := atoi (index $i 1) -}}
{{- $oLen := atoi (index $o 1) -}}
{{- if ge $iLen $oLen -}}
{{- $block := 1 -}}
{{- range until (int (sub 32 $oLen)) -}}{{- $block = mul $block 2 -}}{{- end -}}
{{- if eq (div (int64 (index $i 0)) $block) (div (int64 (index $o 0)) $block) -}}true{{- end -}}
{{- end -}}
{{- end }}

{{/* =========================================================================================
     Install guards (rendered from templates/00-guards.yaml, so every install, upgrade, lint and template
     run passes through them, including renders that skip values.schema.json).
     ========================================================================================= */}}
{{- define "axeraforce.validate" -}}
{{- $d := include "axeraforce.distribution" . | fromJson -}}
{{- $p := include "axeraforce.platform" . | fromJson -}}
{{- $cidrRe := include "axeraforce.cidrRegex" . -}}
{{- $fix := "  kubectl create namespace axera\n  kubectl label namespace axera pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged" -}}

{{- /* 1. Namespace: the Axera API looks for the agent (DaemonSet axera-agent, label app=axera-agent,
       container pcap-capture) and the integration identity only in namespace "axera". */ -}}
{{- if ne .Release.Namespace "axera" -}}
{{- fail (printf "\n\naxera-force must be installed into namespace \"axera\", not %q.\nThe Axera API finds the agent's capture sidecar and the integration identity (axera/axera-integration-sa) only in namespace \"axera\".\nCreate it with Pod Security \"privileged\" and install there:\n%s\n  helm install %s <chart> -n axera -f <values>\n" .Release.Namespace $fix .Release.Name) -}}
{{- end -}}

{{- /* 1b. Keys renamed since the 1.1.1 package that the schema cannot refuse (global takes any key). */ -}}
{{- if hasKey (.Values.global | default dict) "platform" -}}
{{- fail "global.platform was renamed global.distribution (openshift, k3s, rke2, anthos, vanilla or auto) in chart 2.0.0. Move your settings to a values file for this chart (see Upgrading from the 1.1.1 package in the README)." -}}
{{- end -}}

{{- /* 2. Placeholders left in a values file. */ -}}
{{- $texts := list .Values.clusterName .Values.podCIDR .Values.serviceCIDR .Values.localNetworkCIDR .Values.kafka.bootstrapServers .Values.kafka.saslUsername .Values.kafka.saslPassword (.Values.process).criSocket (.Values.auditForwarder).targetUri (.Values.auditForwarder).internalToken (.Values.auditForwarder).logDir -}}
{{- $texts = concat $texts (.Values.extraPodCIDRs | default list) (.Values.extraLocalNetworkCIDRs | default list) -}}
{{- range $texts -}}
{{- if regexMatch "<<<|>>>" (toString .) -}}
{{- fail (printf "a values placeholder is still in place (%q): replace every \"<<< ... >>>\" with your value" (toString .)) -}}
{{- end -}}
{{- end -}}

{{- /* 3. Required values. */ -}}
{{- $_ := required "clusterName is required: the name this cluster is registered under in Axera (it is also its Kafka flow topic)" .Values.clusterName -}}
{{- if not (regexMatch "^[a-zA-Z0-9][a-zA-Z0-9._-]*$" .Values.clusterName) -}}
{{- fail (printf "clusterName %q is not a legal Kafka topic name: use letters, digits, '.', '_' and '-', starting with a letter or digit" .Values.clusterName) -}}
{{- end -}}
{{- if gt (len .Values.clusterName) 241 -}}
{{- fail "clusterName is longer than 241 characters: the \"<clusterName>-process\" topic would exceed Kafka's 249" -}}
{{- end -}}
{{- $_ := required "kafka.bootstrapServers is required: host:port of the central Axera Kafka listener this agent writes to (e.g. kafka.example.com:9093)" .Values.kafka.bootstrapServers -}}
{{- $_ := required "localNetworkCIDR is required: your corporate / on-prem network range (it must not equal or lie inside the pod or Service CIDR)" .Values.localNetworkCIDR -}}

{{- /* 4. CIDRs: well-formed, and the LocalNetwork ranges must label something. The pod CIDR helper fails
       on its own where the distribution has no default. */ -}}
{{- $cluster := include "axeraforce.clusterCIDRs" . | fromJsonArray -}}
{{- $local := prepend (.Values.extraLocalNetworkCIDRs | default list) .Values.localNetworkCIDR -}}
{{- $vips := (.Values.flow).ingressVipCIDRs | default list -}}
{{- range $c := concat $cluster $local $vips -}}
{{- if not (regexMatch $cidrRe (toString $c)) -}}
{{- fail (printf "%q is not an IPv4 CIDR (a.b.c.d/n): check podCIDR, serviceCIDR, extraPodCIDRs, localNetworkCIDR, extraLocalNetworkCIDRs and flow.ingressVipCIDRs" (toString $c)) -}}
{{- end -}}
{{- end -}}
{{- range $l := $local -}}
{{- range $c := $cluster -}}
{{- if include "axeraforce.cidrInside" (dict "inner" (toString $l) "outer" (toString $c)) -}}
{{- $hint := "" -}}
{{- if eq $d.name "anthos" }}{{ $hint = " On Anthos the default pod CIDR is 192.168.0.0/16, the same as this chart's default localNetworkCIDR." }}{{ end -}}
{{- fail (printf "\n\nLocalNetwork range %s equals or lies inside the in-cluster range %s (pod CIDR, extraPodCIDRs or Service CIDR). Those addresses are labelled ClusterSubnet first, so the range would label nothing and your on-prem hosts would read as internet egress.%s Set localNetworkCIDR (and extraLocalNetworkCIDRs) to your corporate ranges outside the cluster's networks; a supernet that contains them, such as 10.0.0.0/8, is fine." $l $c $hint) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- /* k3s / RKE2, live install only: every node's pod range must lie inside the pod ranges, so a cluster
       started with another --cluster-cidr (or a mistyped podCIDR) fails here instead of emptying the
       external-flows lane. */ -}}
{{- if has $d.name (list "k3s" "rke2") -}}
{{- $pods := include "axeraforce.podCIDRs" . | fromJsonArray -}}
{{- range $n := include "axeraforce.nodePodCIDRs" . | fromJsonArray -}}
{{- $in := false -}}
{{- range $c := $pods -}}
{{- if include "axeraforce.cidrInside" (dict "inner" (index $n 1) "outer" (toString $c)) }}{{ $in = true }}{{ end -}}
{{- end -}}
{{- if not $in -}}
{{- $src := ternary (printf "podCIDR %s" (toString $.Values.podCIDR)) "the default pod CIDR 10.42.0.0/16 (podCIDR is empty)" (ne (trim (toString ($.Values.podCIDR | default ""))) "") -}}
{{- fail (printf "\n\nnode %s was given pod range %s, which lies outside %s%s. This cluster was started with another cluster-cidr: set podCIDR to it (cluster-cidr in /etc/rancher/%s/config.yaml, or the server's --cluster-cidr), and serviceCIDR to its service-cidr if that differs from 10.43.0.0/16." (index $n 0) (index $n 1) $src (ternary "" (printf " and extraPodCIDRs %v" $.Values.extraPodCIDRs) (empty $.Values.extraPodCIDRs)) $d.name) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- with .Values.clusterPublicIP -}}
{{- if not (and (regexMatch $cidrRe (toString .)) (hasSuffix "/32" (toString .))) -}}
{{- fail (printf "clusterPublicIP %q must be a single IPv4 address as a /32" (toString .)) -}}
{{- end -}}
{{- end -}}
{{- with .Values.multiCluster -}}
{{- if or (not .cidr) (not .peers) -}}
{{- fail "multiCluster needs both cidr and peers (a list of {name, publicIP, globalCidr}); leave multiCluster: {} for a single cluster" -}}
{{- end -}}
{{- if not (regexMatch $cidrRe (toString .cidr)) -}}
{{- fail (printf "multiCluster.cidr %q is not an IPv4 CIDR" (toString .cidr)) -}}
{{- end -}}
{{- range .peers -}}
{{- if or (not .name) (not (regexMatch $cidrRe (toString .publicIP))) -}}
{{- fail "every multiCluster.peers entry needs a name and a publicIP as an IPv4 /32" -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- with .Values.submariner -}}
{{- range $k := list "globalCidr" "clusterGlobalCidr" -}}
{{- with (index $.Values.submariner $k) -}}
{{- if not (regexMatch $cidrRe (toString .)) -}}
{{- fail (printf "submariner.%s %q is not an IPv4 CIDR" $k (toString .)) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /* 5. Kafka. */ -}}
{{- if not (has .Values.kafka.securityProtocol (list "Plaintext" "Ssl" "SaslPlaintext" "SaslSsl")) -}}
{{- fail (printf "kafka.securityProtocol must be Plaintext, Ssl, SaslPlaintext or SaslSsl, not %q" .Values.kafka.securityProtocol) -}}
{{- end -}}
{{- if not (has .Values.kafka.saslMechanism (list "Plain" "ScramSha512" "ScramSha256")) -}}
{{- fail (printf "kafka.saslMechanism must be ScramSha512 or Plain, not %q" .Values.kafka.saslMechanism) -}}
{{- end -}}
{{- if eq .Values.kafka.saslMechanism "ScramSha256" -}}
{{- fail "kafka.saslMechanism ScramSha256 is not supported: the agent's flow pipeline can log in only with Plain or SCRAM-SHA-512, so no flows would ever reach Axera. Give the agent's Kafka user a SCRAM-SHA-512 credential and set kafka.saslMechanism: ScramSha512." -}}
{{- end -}}
{{- if and (include "axeraforce.sasl" .) .Values.kafka.createSecret (or (not (trim (.Values.kafka.saslUsername | default ""))) (not (trim (.Values.kafka.saslPassword | default "")))) -}}
{{- fail "kafka.createSecret: true with a SASL protocol needs kafka.saslUsername and kafka.saslPassword. Better: keep kafka.createSecret: false and create Secret kafka-sasl (keys username, password) in namespace axera yourself" -}}
{{- end -}}
{{- if and (include "axeraforce.tls" .) .Values.kafka.createSecret (not .Values.kafka.insecureSkipVerify) (not .Values.kafka.systemTrustStore) (not (trim (.Values.kafka.caCert | default ""))) -}}
{{- fail "kafka.createSecret: true with Ssl / SaslSsl needs kafka.caCert (the PEM of the broker's CA), or kafka.systemTrustStore: true when the broker certificate chains to a public CA the images trust" -}}
{{- end -}}
{{- $_ := include "axeraforce.kafkaCompression" . -}}

{{- /* 6. Topics. ONE cluster identity: Axera names a cluster's flows after their topic, derives its process
       and DNS topics from the registered name (<c>-process, <c>-dns) and the egress lane stamps clusterName,
       so the flow topic may only repeat clusterName. */ -}}
{{- if and .Values.flow.topic (ne (toString .Values.flow.topic) (toString .Values.clusterName)) -}}
{{- fail (printf "flow.topic %q must be empty or equal clusterName %q: Axera derives the process and DNS topics and the egress lane's cluster label from clusterName, so a different flow topic splits this cluster in two. Set clusterName to the name you register in Axera and leave flow.topic empty." (toString .Values.flow.topic) (toString .Values.clusterName)) -}}
{{- end -}}
{{- with (.Values.process).topic -}}
{{- $want := printf "%s-process" $.Values.clusterName -}}
{{- if ne (toString .) $want -}}
{{- fail (printf "process.topic %q must be %q (clusterName followed by -process): Axera maps a process topic to its cluster by that name. Leave process.topic empty to use it." (toString .) $want) -}}
{{- end -}}
{{- end -}}
{{- if and (.Values.flow).dnsVisibility (not (.Values.flow).enableDnsTracking) -}}
{{- fail "flow.dnsVisibility needs flow.enableDnsTracking: true (without DNS tracking the DNS topic would stay empty)" -}}
{{- end -}}
{{- /* Every lane its own topic: Radar reads each topic with one consumer, so records sharing a topic are
       misfiled. */ -}}
{{- $lanes := list (list "flow (clusterName)" (include "axeraforce.flowTopic" .)) (list "external-flow (flow.externalTopic)" (toString .Values.flow.externalTopic)) (list "process (process.topic)" (include "axeraforce.processTopic" .)) -}}
{{- if (.Values.flow).dnsVisibility }}{{ $lanes = append $lanes (list "DNS (flow.dnsTopic)" (include "axeraforce.dnsTopic" .)) }}{{ end -}}
{{- if .Values.submariner }}{{ $lanes = append $lanes (list "intercluster (submariner.topic)" (toString ((.Values.submariner).topic | default "intercluster-flows"))) }}{{ end -}}
{{- if include "axeraforce.ingress" . }}{{ $lanes = append $lanes (list "ingress (flow.ingress.topic)" (include "axeraforce.ingressTopic" .)) }}{{ end -}}
{{- $seen := dict -}}
{{- range $lanes -}}
{{- $t := index . 1 -}}
{{- if hasKey $seen $t -}}
{{- fail (printf "the %s topic %q is also the %s topic. Radar reads each topic with one consumer, so the records would be misfiled: give each lane its own topic." (index . 0) $t (get $seen $t)) -}}
{{- end -}}
{{- $_ := set $seen $t (index . 0) -}}
{{- end -}}

{{- /* 7. The shipper's producer queue cap (also enforced by values.schema.json); unset = 16384. */ -}}
{{- $q := (.Values.process).shipperQueueMaxKbytes -}}
{{- if not (kindIs "invalid" $q) -}}
{{- if not (or (kindIs "float64" $q) (kindIs "int64" $q) (kindIs "int" $q)) -}}
{{- fail (printf "process.shipperQueueMaxKbytes must be a whole number of KiB, at least 1024 (default 16384), not %v" $q) -}}
{{- else if or (lt (float64 $q) 1024.0) (ne (float64 $q) (float64 (int64 $q))) -}}
{{- fail (printf "process.shipperQueueMaxKbytes must be a whole number of KiB, at least 1024 (default 16384), not %v" $q) -}}
{{- end -}}
{{- end -}}
{{- with (.Values.process).criSocket -}}
{{- if and (ne (toString .) "none") (not (hasPrefix "/" (toString .))) -}}
{{- fail (printf "process.criSocket %q must be an absolute path (e.g. /run/containerd/containerd.sock), or \"none\"" (toString .)) -}}
{{- end -}}
{{- end -}}

{{- /* 8. Flow agent and the ingress lane. */ -}}
{{- $tc := include "axeraforce.tcAttachMode" . -}}
{{- if not (has $tc (list "any" "tcx" "tc")) -}}
{{- fail (printf "flow.tcAttachMode must be any, tcx or tc (or empty: tcx on anthos, any elsewhere), not %q" $tc) -}}
{{- end -}}
{{- if ne $tc "tcx" -}}
{{- /* Why tc / any would break pod networking here, or "". The first two need no cluster access (an offline
       render refuses them too); the rest are install / upgrade-time lookups. */ -}}
{{- $why := "" -}}
{{- if eq $d.name "anthos" -}}
{{- $why = "distribution anthos runs an eBPF datapath (Dataplane V2) that attaches its own TC programs" -}}
{{- else if .Capabilities.APIVersions.Has "cilium.io/v2" -}}
{{- $why = "the API server serves cilium.io/v2, the API of an eBPF CNI that attaches its own TC programs" -}}
{{- else if and $p.openshift (eq $p.networkType "Cilium") -}}
{{- $why = printf "this cluster's network plugin (networkType %s) attaches its own TC programs" $p.networkType -}}
{{- end -}}
{{- if not $why -}}
{{- range $dsNs := list (list "kube-system" "cilium") (list "kube-system" "anetd") (list "cilium" "cilium") -}}
{{- if and (not $why) (lookup "apps/v1" "DaemonSet" (index $dsNs 0) (index $dsNs 1)) -}}
{{- $why = printf "namespace %s runs DaemonSet %s, a CNI that attaches its own TC programs" (index $dsNs 0) (index $dsNs 1) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- if and (not $why) (.Capabilities.APIVersions.Has "operator.tigera.io/v1/Installation") -}}
{{- if eq (toString (dig "spec" "calicoNetwork" "linuxDataplane" "" (lookup "operator.tigera.io/v1" "Installation" "" "default" | default dict))) "BPF" -}}
{{- $why = "Calico runs its eBPF dataplane (Installation default, linuxDataplane BPF), which attaches its own TC programs" -}}
{{- end -}}
{{- end -}}
{{- if and (not $why) (.Capabilities.APIVersions.Has "crd.projectcalico.org/v1/FelixConfiguration") -}}
{{- if eq (toString (dig "spec" "bpfEnabled" false (lookup "crd.projectcalico.org/v1" "FelixConfiguration" "" "default" | default dict))) "true" -}}
{{- $why = "Calico runs its eBPF dataplane (FelixConfiguration default, bpfEnabled), which attaches its own TC programs" -}}
{{- end -}}
{{- end -}}
{{- if $why -}}
{{- fail (printf "\n\nflow.tcAttachMode %q cannot be used on this cluster: %s. On a node without TCX (kernel older than 6.6) the flow agent's legacy TC mode replaces the interface's clsact qdisc and removes those programs, which breaks pod networking on that node. Set flow.tcAttachMode: tcx (nodes need kernel 6.6 or later, or a vendor kernel with TCX, to capture flows)." $tc $why) -}}
{{- end -}}
{{- end -}}
{{- if and (include "axeraforce.ingress" .) (not $p.openshift) -}}
{{- fail (printf "flow.ingress.enabled is OpenShift-only: the north-south ingress lane relies on OVN-Kubernetes node annotations, which distribution %q does not have. Set flow.ingress.enabled: false." $d.name) -}}
{{- end -}}

{{- /* 9. Audit forwarder. */ -}}
{{- if (.Values.auditForwarder).enabled -}}
{{- if eq $d.name "anthos" -}}
{{- fail "auditForwarder.enabled is not supported on Anthos: the API server's audit log is not a file on user-cluster nodes (it goes to a volume or to Cloud Audit Logs). Set auditForwarder.enabled: false." -}}
{{- end -}}
{{- if not (.Values.auditForwarder).targetUri -}}
{{- fail "auditForwarder.enabled needs auditForwarder.targetUri: the central Axera API's audit endpoint, https://<central API host>/api/Internal/Audit" -}}
{{- end -}}
{{- if not (.Values.auditForwarder).internalToken -}}
{{- fail "auditForwarder.enabled needs auditForwarder.internalToken: the central platform's internal token (pass it with --set or a values file kept out of version control)" -}}
{{- end -}}
{{- $dir := include "axeraforce.auditLogDir" . -}}
{{- if not $dir -}}
{{- fail (printf "auditForwarder.logDir is required on distribution %q: the host directory where the API server writes audit.log (k3s: /var/lib/rancher/k3s/server/logs, RKE2: /var/lib/rancher/rke2/server/logs; the cluster must have API auditing turned on)" $d.name) -}}
{{- end -}}
{{- if not (hasPrefix "/" $dir) -}}
{{- fail (printf "auditForwarder.logDir %q must be an absolute host path" $dir) -}}
{{- end -}}
{{- end -}}

{{- /* 10. Enumerations the schema also checks. */ -}}
{{- $nr := toString ((.Values.integration).namespacedRoles | default "auto") -}}
{{- if not (has $nr (list "auto" "always" "never")) -}}
{{- fail (printf "integration.namespacedRoles must be auto, always or never, not %q" $nr) -}}
{{- end -}}
{{- $scc := .Values.createSCC -}}
{{- if not (kindIs "bool" $scc) -}}
{{- if not (has (toString ($scc | default "auto")) (list "auto" "true" "false")) -}}
{{- fail (printf "createSCC must be auto, true or false, not %q" (toString $scc)) -}}
{{- end -}}
{{- end -}}

{{- /* 11. Pod Security: refuse a namespace that enforces less than privileged (install/upgrade only: helm
       template cannot look). OpenShift admits the agent through its SCC instead. */ -}}
{{- if not $p.openshift -}}
{{- $ns := lookup "v1" "Namespace" "" .Release.Namespace -}}
{{- if $ns -}}
{{- $enforce := index (($ns.metadata).labels | default dict) "pod-security.kubernetes.io/enforce" | default "" -}}
{{- if and $enforce (ne $enforce "privileged") -}}
{{- fail (printf "\n\nnamespace %s enforces Pod Security %q; the agent (hostNetwork, hostPID, host paths, added capabilities) needs \"privileged\":\n  kubectl label namespace %s --overwrite pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged\n" .Release.Namespace $enforce .Release.Namespace) -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /* 12. integration.create (install / upgrade only): an axera-integration-sa or axera-sa-token this release
       does not own (made from the static integration manifest, or kept from a release with another name)
       would stop Helm with a bare ownership error. Its token may already be registered in Axera, so say how
       to adopt it instead of deleting it. */ -}}
{{- if (.Values.integration).create -}}
{{- $foreign := list -}}
{{- range $o := list (list "ServiceAccount" "serviceaccount/axera-integration-sa") (list "Secret" "secret/axera-sa-token") -}}
{{- $obj := lookup "v1" (index $o 0) $.Release.Namespace (last (splitList "/" (index $o 1))) -}}
{{- if $obj -}}
{{- $a := (($obj.metadata).annotations) | default dict -}}
{{- if or (ne (toString (index $a "meta.helm.sh/release-name")) $.Release.Name) (ne (toString (index $a "meta.helm.sh/release-namespace")) $.Release.Namespace) -}}
{{- $foreign = append $foreign (index $o 1) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- if $foreign -}}
{{- fail (printf "\n\n%s already exist(s) in namespace %s and belong(s) to no Helm release named %q (created from the static integration manifest, or kept from a release with another name). The token may already be registered in Axera: do NOT delete them. Adopt them into this release, then run the same helm command again:\n  kubectl -n %s label %s app.kubernetes.io/managed-by=Helm --overwrite\n  kubectl -n %s annotate %s meta.helm.sh/release-name=%s meta.helm.sh/release-namespace=%s --overwrite\nOr keep them outside this chart with integration.create: false.\n" (join " and " $foreign) .Release.Namespace .Release.Name .Release.Namespace (join " " $foreign) .Release.Namespace (join " " $foreign) .Release.Name .Release.Namespace) -}}
{{- end -}}
{{- end -}}
{{- end }}
