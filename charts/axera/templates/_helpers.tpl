{{/* =========================================================================
     Common labels — applied to all resources for traceability.
========================================================================= */}}
{{- define "axera.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/* =========================================================================
     axera.init — resolved once per render and called at the top of every template.
       1. global.namespace: empty → the release namespace. "axera" is refused (it is the agent
          namespace). A value other than the release namespace is refused unless the chart
          creates the namespace itself (global.createNamespace), so the release record and the
          workloads never split across two namespaces.
       2. The distribution (axera.distribution below), memoised under global._axeraDistribution
          together with how it was found (global._axeraDetectedBy: explicit | apis | nodes | none).
     The resolved values are written back into .Values.global for this render only; nothing is
     persisted. Always call with the root context.
========================================================================= */}}
{{- define "axera.init" -}}
{{- $g := .Values.global -}}
{{- if not (hasKey $g "_axeraInit") -}}
{{- $ns := toString ($g.namespace | default .Release.Namespace) -}}
{{- if eq $ns "axera" -}}
{{- fail "\n\nThe namespace \"axera\" is reserved for the agent chart (axera-force). Create a namespace of its own with the Pod Security labels (README, \"Prepare the namespace\"), for example axera-central, then:\n  helm upgrade --install axera axera/axera -n axera-central ...\n" -}}
{{- end -}}
{{- if and (ne $ns .Release.Namespace) (not $g.createNamespace) -}}
{{- fail (printf "\n\nglobal.namespace (%q) differs from the release namespace (%q). Install the release into that namespace (helm ... -n %s), or leave global.namespace empty.\n" $ns .Release.Namespace $ns) -}}
{{- end -}}
{{- $_ := set $g "namespace" $ns -}}
{{- $d := lower (toString ($g.distribution | default "auto")) -}}
{{- if not (has $d (list "auto" "openshift" "k3s" "rke2" "anthos" "vanilla")) -}}
{{- fail (printf "global.distribution must be auto, openshift, k3s, rke2, anthos or vanilla, not %q" $d) -}}
{{- end -}}
{{- $by := "explicit" -}}
{{- $p := lower (toString ($g.platform | default "")) -}}
{{- if not (has $p (list "" "auto" "openshift" "kubernetes")) -}}
{{- fail (printf "global.platform (deprecated, use global.distribution) must be auto, openshift or kubernetes, not %q" $p) -}}
{{- end -}}
{{- if and (eq $d "auto") (eq $p "openshift") -}}
{{- $d = "openshift" -}}
{{- end -}}
{{- if eq $d "auto" -}}
{{- if and (ne $p "kubernetes") (or (.Capabilities.APIVersions.Has "route.openshift.io/v1") (.Capabilities.APIVersions.Has "security.openshift.io/v1")) -}}
{{- $d = "openshift" -}}
{{- $by = "apis" -}}
{{- else -}}
{{- $kv := "" -}}
{{- range ((lookup "v1" "Node" "" "").items | default list) -}}
{{- if not $kv }}{{ $kv = toString (dig "status" "nodeInfo" "kubeletVersion" "" .) }}{{ end -}}
{{- end -}}
{{- if not $kv -}}
{{- $d = "vanilla" -}}
{{- $by = "none" -}}
{{- else -}}
{{- $by = "nodes" -}}
{{- if contains "+k3s" $kv -}}{{- $d = "k3s" -}}
{{- else if contains "+rke2" $kv -}}{{- $d = "rke2" -}}
{{- else if contains "-gke." $kv -}}{{- $d = "anthos" -}}
{{- else -}}{{- $d = "vanilla" -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- $_ := set $g "_axeraDistribution" $d -}}
{{- $_ := set $g "_axeraDetectedBy" $by -}}
{{- $_ := set $g "_axeraInit" true -}}
{{- end -}}
{{- end }}

{{/* The distribution: openshift | k3s | rke2 | anthos | vanilla. */}}
{{- define "axera.distribution" -}}
{{- include "axera.init" . -}}
{{- .Values.global._axeraDistribution -}}
{{- end }}

{{/* "true" on OpenShift, empty elsewhere. */}}
{{- define "axera.isOpenShift" -}}
{{- if eq (include "axera.distribution" .) "openshift" -}}true{{- end -}}
{{- end }}

{{/* "true" when the SecurityContextConstraints and their use grant render: OpenShift only, and
     global.createSCC is not false (auto | true | false). */}}
{{- define "axera.createSCC" -}}
{{- $raw := .Values.global.createSCC -}}
{{- $v := "auto" -}}
{{- if kindIs "bool" $raw }}{{ $v = toString $raw }}{{ else if $raw }}{{ $v = lower (toString $raw) }}{{ end -}}
{{- if not (has $v (list "auto" "true" "false")) -}}
{{- fail (printf "global.createSCC must be auto, true or false, not %q" $v) -}}
{{- end -}}
{{- if and (include "axera.isOpenShift" .) (ne $v "false") -}}true{{- end -}}
{{- end }}

{{/* "true" when the AllowDropMonitor (OVN-Kubernetes ACL log collector) runs:
     allowDropMonitor.enabled auto (OpenShift only) | true | false. */}}
{{- define "axera.admEnabled" -}}
{{- $v := lower (toString (dig "enabled" "auto" (.Values.allowDropMonitor | default dict))) -}}
{{- if not (has $v (list "auto" "true" "false")) -}}
{{- fail (printf "allowDropMonitor.enabled must be auto, true or false, not %q" $v) -}}
{{- end -}}
{{- if or (eq $v "true") (and (eq $v "auto") (include "axera.isOpenShift" .)) -}}true{{- end -}}
{{- end }}

{{/* =========================================================================
     How the UI is published: Route | Ingress | Istio | LoadBalancer | ClusterIP.
     expose.type auto → Route on OpenShift, Istio on anthos, Ingress everywhere else. The value
     is matched case-insensitively and rendered in its canonical spelling.
========================================================================= */}}
{{- define "axera.exposeType" -}}
{{- $raw := ((.Values.expose).type | default "auto") | toString -}}
{{- $canon := dict "auto" "auto" "route" "Route" "ingress" "Ingress" "istio" "Istio" "loadbalancer" "LoadBalancer" "clusterip" "ClusterIP" -}}
{{- $t := get $canon (lower $raw) -}}
{{- if not $t -}}
{{- fail (printf "expose.type must be auto, Route, Ingress, Istio, LoadBalancer or ClusterIP, not %q" $raw) -}}
{{- end -}}
{{- $d := include "axera.distribution" . -}}
{{- if eq $t "auto" -}}
{{- $t = get (dict "openshift" "Route" "anthos" "Istio") $d | default "Ingress" -}}
{{- end -}}
{{- if and (eq $t "Route") (ne $d "openshift") -}}
{{- fail (printf "expose.type=Route needs OpenShift (route.openshift.io/v1); this render resolved the distribution to %q. Use Ingress, Istio, LoadBalancer or ClusterIP, or set global.distribution=openshift if this really is OpenShift." $d) -}}
{{- end -}}
{{- $t -}}
{{- end }}

{{/* The IngressClass of the Ingress: expose.ingress.className, else traefik on k3s, nginx on
     rke2, and none (the cluster's default IngressClass) elsewhere. */}}
{{- define "axera.ingressClassName" -}}
{{- $c := ((.Values.expose).ingress).className | default "" -}}
{{- if not $c -}}
{{- $c = get (dict "k3s" "traefik" "rke2" "nginx") (include "axera.distribution" .) | default "" -}}
{{- end -}}
{{- $c -}}
{{- end }}

{{/* =========================================================================
     OpenShift Route hostnames (expose.type=Route only).
     Priority: explicit host > derived <route>-<ns>.<clusterDomain> >
     empty (OpenShift auto-assigns the hostname from its default domain).
========================================================================= */}}
{{- define "axera.frontendHost" -}}
{{- if .Values.routes.frontend.host -}}
{{- .Values.routes.frontend.host -}}
{{- else if .Values.global.clusterDomain -}}
{{- printf "frontend-%s.%s" .Values.global.namespace .Values.global.clusterDomain -}}
{{- end -}}
{{- end }}

{{- define "axera.kafkaUiHost" -}}
{{- if .Values.routes.kafkaUi.host -}}
{{- .Values.routes.kafkaUi.host -}}
{{- else if .Values.global.clusterDomain -}}
{{- printf "kafka-ui-%s.%s" .Values.global.namespace .Values.global.clusterDomain -}}
{{- end -}}
{{- end }}

{{- define "axera.apiHost" -}}
{{- if (.Values.routes.api).host -}}
{{- .Values.routes.api.host -}}
{{- else if .Values.global.clusterDomain -}}
{{- printf "api-%s.%s" .Values.global.namespace .Values.global.clusterDomain -}}
{{- end -}}
{{- end }}

{{/* =========================================================================
     The public host and URL users browse to. They feed AllowedCorsOrigins, the OAuth redirect
     base and NEXT_PUBLIC_APP_URL (11-configmaps.yaml). Empty is safe: browser API calls are
     same-origin (/api).
       Route  → axera.frontendHost, always https.
       others → expose.frontend.host, https when expose.frontend.tls is true.
========================================================================= */}}
{{- define "axera.publicHost" -}}
{{- if eq (include "axera.exposeType" .) "Route" -}}
{{- include "axera.frontendHost" . -}}
{{- else -}}
{{- ((.Values.expose).frontend).host | default "" -}}
{{- end -}}
{{- end }}

{{- define "axera.publicUrl" -}}
{{- $host := include "axera.publicHost" . -}}
{{- $type := include "axera.exposeType" . -}}
{{- if $host -}}
{{- if eq $type "Route" -}}
{{- printf "https://%s" $host -}}
{{- else if ((.Values.expose).frontend).tls -}}
{{- printf "https://%s" $host -}}
{{- else if and (eq $type "LoadBalancer") (ne (toString (((.Values.expose).frontend).servicePort | default 3000)) "80") -}}
{{- printf "http://%s:%v" $host (((.Values.expose).frontend).servicePort | default 3000) -}}
{{- else -}}
{{- printf "http://%s" $host -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* The frontend Service type: LoadBalancer only for expose.type=LoadBalancer. */}}
{{- define "axera.frontendServiceType" -}}
{{- if eq (include "axera.exposeType" .) "LoadBalancer" -}}LoadBalancer{{- else -}}ClusterIP{{- end -}}
{{- end }}

{{/* Is the MCP tool server reachable from outside? Only a path-aware front door (Route,
     Ingress, Istio) can send /api/mcp to the mcp Service. */}}
{{- define "axera.mcpExposed" -}}
{{- if (.Values.mcp).enabled -}}
{{- $t := include "axera.exposeType" . -}}
{{- if or (has $t (list "Ingress" "Istio")) (and (eq $t "Route") .Values.routes.frontend.enabled) -}}
true
{{- end -}}
{{- end -}}
{{- end }}

{{/* Is kafka-ui published outside the cluster? (A Route with routes.kafkaUi.enabled, or an
     Istio VirtualService with kafka.uiIstioHost.) kafka-ui has NO authentication. */}}
{{- define "axera.kafkaUiExposed" -}}
{{- if include "axera.kafkaUiEnabled" . -}}
{{- $t := include "axera.exposeType" . -}}
{{- if or (and (eq $t "Route") .Values.routes.kafkaUi.enabled) (and (eq $t "Istio") (.Values.kafka).uiIstioHost) -}}
true
{{- end -}}
{{- end -}}
{{- end }}

{{/* The front-door request timeout of the Ingress / Istio front door (expose.frontend.timeout,
     default 180s), validated once and always with its unit: "180" and "180s" both give "180s".
     Istio needs the unit (a duration string); the nginx annotations take the bare number. */}}
{{- define "axera.frontDoorTimeout" -}}
{{- $t := toString (((.Values.expose).frontend).timeout | default "180s") -}}
{{- if not (regexMatch "^[0-9]+s?$" $t) -}}
{{- fail (printf "expose.frontend.timeout must be a number of seconds such as \"180s\", not %q" $t) -}}
{{- end -}}
{{- printf "%ss" (trimSuffix "s" $t) -}}
{{- end }}

{{/* "true" when the agents' audit ingest path (POST /api/Internal/Audit, exact) is published on the
     UI host for remote audit forwarders: expose.auditIngest.enabled with an Ingress or Istio front
     door. A Route publishes it with routes.api.enabled instead; a LoadBalancer or ClusterIP front
     door cannot route by path, so asking for it there fails. */}}
{{- define "axera.auditIngestExposed" -}}
{{- if ((.Values.expose).auditIngest).enabled -}}
{{- $t := include "axera.exposeType" . -}}
{{- if has $t (list "Ingress" "Istio") -}}
true
{{- else if has $t (list "LoadBalancer" "ClusterIP") -}}
{{- fail (printf "expose.auditIngest.enabled needs a front door that routes by path (Ingress or Istio); expose.type resolved to %s. On OpenShift Routes use routes.api.enabled instead." $t) -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/* Istio Gateway helpers (expose.type=Istio). */}}
{{- define "axera.gatewayName" -}}
{{- default "axera-gateway" .Values.istio.virtualService.gatewayName -}}
{{- end }}

{{- define "axera.gatewayRef" -}}
{{- if .Values.istio.virtualService.createGateway -}}
{{- printf "%s/%s" .Values.global.namespace (include "axera.gatewayName" .) -}}
{{- else -}}
{{- .Values.istio.virtualService.gateway -}}
{{- end -}}
{{- end }}

{{/* Cluster DNS domain (kubelet --cluster-domain). */}}
{{- define "axera.clusterDnsDomain" -}}
{{- .Values.global.clusterDnsDomain | default "cluster.local" -}}
{{- end }}

{{/* =========================================================================
     Container hardening of the product containers (api, allowdropmonitor, radar,
     networkpolicywatcher, frontend). podSecurity.hardenAppContainers:
       auto (default) → on everywhere except OpenShift (the SCC assigns these there);
       true / false   → force.
     The images run as the numeric USER 1001 with a group-0 writable /app, so runAsNonRoot holds
     without a runAsUser. Never add readOnlyRootFilesystem: the frontend writes /app/public/env.js
     at start.
========================================================================= */}}
{{- define "axera.hardenAppContainers" -}}
{{- $h := lower (toString (dig "hardenAppContainers" "auto" (.Values.podSecurity | default dict))) -}}
{{- if or (eq $h "auto") (eq $h "") -}}
{{- if not (include "axera.isOpenShift" .) -}}true{{- end -}}
{{- else if eq $h "true" -}}
true
{{- else if ne $h "false" -}}
{{- fail (printf "podSecurity.hardenAppContainers must be auto, true or false, not %q" $h) -}}
{{- end -}}
{{- end }}

{{- define "axera.appContainerSecurityContext" -}}
{{- if include "axera.hardenAppContainers" . -}}
securityContext:
  allowPrivilegeEscalation: false
  runAsNonRoot: true
  capabilities: { drop: [ALL] }
  seccompProfile: { type: RuntimeDefault }
{{- end -}}
{{- end }}

{{/* =========================================================================
     Istio sidecar opt-out for the chart's run-to-completion pods (migrate Jobs, trial
     bootstrap, model pull, helm test): an injected sidecar never exits, so the Job would never
     complete. istio.disableSidecarOnJobs: auto (default: on for anthos and for expose.type
     Istio) | true | false. Both forms are set: the pod label (current Istio) and the annotation
     (older releases).
========================================================================= */}}
{{- define "axera.jobSidecarOptOut" -}}
{{- $v := lower (toString (dig "disableSidecarOnJobs" "auto" (.Values.istio | default dict))) -}}
{{- if not (has $v (list "auto" "true" "false")) -}}
{{- fail (printf "istio.disableSidecarOnJobs must be auto, true or false, not %q" $v) -}}
{{- end -}}
{{- if or (eq $v "true") (and (eq $v "auto") (or (eq (include "axera.distribution" .) "anthos") (eq (include "axera.exposeType" .) "Istio"))) -}}true{{- end -}}
{{- end }}

{{- define "axera.jobPodSidecarLabel" -}}
{{- if include "axera.jobSidecarOptOut" . -}}
sidecar.istio.io/inject: "false"
{{- end -}}
{{- end }}

{{- define "axera.jobPodSidecarAnnotation" -}}
{{- if include "axera.jobSidecarOptOut" . -}}
sidecar.istio.io/inject: "false"
{{- end -}}
{{- end }}

{{/* =========================================================================
     Image full path: <registry>/<repo>:<tag>, or <registry>/<repo>@<digest> when a digest is
     set. registry defaults to global.imageRegistry.
     Usage: {{ include "axera.image" (dict "img" .Values.images.api "ctx" .) }}
========================================================================= */}}
{{- define "axera.image" -}}
{{- $reg := toString (.img.registry | default .ctx.Values.global.imageRegistry) -}}
{{- if .img.digest -}}
{{- printf "%s/%s@%s" $reg .img.repo .img.digest -}}
{{- else -}}
{{- printf "%s/%s:%s" $reg .img.repo (toString .img.tag) -}}
{{- end -}}
{{- end }}

{{/* =========================================================================
     PostgreSQL image flavour: images.postgres.flavor auto (rhel on OpenShift, alpine
     elsewhere) | rhel | alpine. The two images differ in env names, data path and user:
       rhel   — Red Hat sclorg image: POSTGRESQL_*, /var/lib/pgsql/data, uid 26, tuning include dir.
       alpine — community image: POSTGRES_*, PGDATA in a subdirectory, uid 70, tuning as -c args.
     There is no in-place switch between them (00-validate.yaml refuses it).
========================================================================= */}}
{{- define "axera.pgFlavor" -}}
{{- $f := lower (toString (dig "flavor" "auto" (.Values.images.postgres | default dict))) -}}
{{- if eq $f "auto" -}}
{{- $f = ternary "rhel" "alpine" (eq (include "axera.isOpenShift" .) "true") -}}
{{- end -}}
{{- if not (has $f (list "rhel" "alpine")) -}}
{{- fail (printf "images.postgres.flavor must be auto, rhel or alpine, not %q" $f) -}}
{{- end -}}
{{- $f -}}
{{- end }}

{{- define "axera.postgresImage" -}}
{{- include "axera.image" (dict "img" (index .Values.images.postgres (include "axera.pgFlavor" .)) "ctx" .) -}}
{{- end }}

{{/* The image the API's backup and restore Jobs run: backup.pgImage, else the in-cluster server's
     own image (PostgreSQL 16: pg_restore from a newer major sends settings a 16 server rejects, so
     every restore would fail), else, with an external database, images.postgresBackup.<flavour>. */}}
{{- define "axera.backupPgImage" -}}
{{- if .Values.backup.pgImage -}}
{{- .Values.backup.pgImage -}}
{{- else if not .Values.postgres.external -}}
{{- include "axera.postgresImage" . -}}
{{- else -}}
{{- include "axera.image" (dict "img" (index .Values.images.postgresBackup (include "axera.pgFlavor" .)) "ctx" .) -}}
{{- end -}}
{{- end }}

{{/* "true" when the api pod mounts the shared /backups volume (backup.storage: a claim the chart
     creates or one you name, or an NFS share). Without it the API reports backups unavailable. */}}
{{- define "axera.backupVolumeEnabled" -}}
{{- $st := .Values.backup.storage | default dict -}}
{{- if and .Values.backup.enabled (or (and (eq $st.type "pvc") (or $st.createPvc $st.pvcClaimName)) (and (eq $st.type "nfs") ($st.nfs | default dict).server ($st.nfs | default dict).path)) -}}true{{- end -}}
{{- end }}

{{/* The numeric user of the flavour's postgres account. */}}
{{- define "axera.pgUid" -}}
{{- if eq (include "axera.pgFlavor" .) "rhel" -}}26{{- else -}}70{{- end -}}
{{- end }}

{{/* securityContext of a container that only runs psql / pg_isready, off OpenShift (the SCC
     assigns one there). Usage: {{- include "axera.pgClientSecurityContext" . | nindent <n> }} */}}
{{- define "axera.pgClientSecurityContext" -}}
{{- if include "axera.hardenAppContainers" . -}}
securityContext:
  runAsUser: {{ include "axera.pgUid" . }}
  runAsGroup: {{ include "axera.pgUid" . }}
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  capabilities: { drop: [ALL] }
  seccompProfile: { type: RuntimeDefault }
{{- end -}}
{{- end }}

{{/* =========================================================================
     Secret names. secrets.existingSecrets.{db,app,kafka} names a Secret you created yourself
     (same keys as the chart's); the chart then renders no Secret of that kind and every
     workload reads the named one.
========================================================================= */}}
{{- define "axera.dbSecretName" -}}
{{- dig "existingSecrets" "db" "" (.Values.secrets | default dict) | default "axera-db-secrets" -}}
{{- end }}

{{- define "axera.appSecretName" -}}
{{- dig "existingSecrets" "app" "" (.Values.secrets | default dict) | default "axera-app-secret" -}}
{{- end }}

{{- define "axera.kafkaSecretName" -}}
{{- dig "existingSecrets" "kafka" "" (.Values.secrets | default dict) | default "kafka-external-secret" -}}
{{- end }}

{{/* =========================================================================
     Data tier (00-validate.yaml): the tier these values ask for, and the one recorded on the
     installed Secrets (annotation, else classified by content). Empty when nothing is recorded,
     which is always the case under helm template, --dry-run and GitOps renders, where lookup
     answers empty.
========================================================================= */}}
{{- define "axera.pgTier" -}}
{{- if .Values.postgres.external -}}external{{- else -}}internal{{- end -}}
{{- end }}

{{- define "axera.kafkaTier" -}}
{{- if .Values.kafka.external -}}external{{- else -}}internal{{- end -}}
{{- end }}

{{- define "axera.pgTierRecorded" -}}
{{- $s := lookup "v1" "Secret" .Values.global.namespace (include "axera.dbSecretName" .) | default dict -}}
{{- $ann := ($s.metadata | default dict).annotations | default dict -}}
{{- $t := index $ann "platform.axerasecurity.com/postgres-tier" | default (index $ann "axera.io/postgres-tier") | default "" | toString -}}
{{- if not (has $t (list "internal" "external")) -}}
{{-   $t = "" -}}
{{-   $conn := index ($s.data | default dict) "APP_DB_CONNSTR" | default "" | b64dec -}}
{{-   $hostKv := regexFind `(?i)(^|;)\s*(host|server)\s*=[^;]*` $conn -}}
{{-   if $hostKv -}}
{{-     $host := regexReplaceAll `(?i)^;?\s*(host|server)\s*=\s*` $hostKv "" | trim | lower -}}
{{-     $t = ternary "internal" "external" (or (eq $host "postgres-app") (hasPrefix "postgres-app." $host)) -}}
{{-   end -}}
{{- end -}}
{{- $t -}}
{{- end }}

{{/* The PostgreSQL image flavour the installation runs: the annotation
     platform.axerasecurity.com/postgres-flavor on the db Secret, else classified from the running
     StatefulSet postgres-app (charts before 3.0 never wrote the annotation, nor does a Secret of
     your own): POSTGRESQL_* env or the Red Hat image → rhel; POSTGRES_USER / PGDATA → alpine.
     Empty when neither tells. */}}
{{- define "axera.pgFlavorRecorded" -}}
{{- $s := lookup "v1" "Secret" .Values.global.namespace (include "axera.dbSecretName" .) | default dict -}}
{{- $f := index (($s.metadata | default dict).annotations | default dict) "platform.axerasecurity.com/postgres-flavor" | default "" | toString -}}
{{- if not (has $f (list "rhel" "alpine")) -}}
{{-   $f = "" -}}
{{-   $sts := lookup "apps/v1" "StatefulSet" .Values.global.namespace "postgres-app" | default dict -}}
{{-   range (dig "spec" "template" "spec" "containers" list $sts) -}}
{{-     if and (not $f) (eq (toString .name) "postgres") -}}
{{-       $names := list -}}
{{-       range (.env | default list) }}{{ $names = append $names (toString .name) }}{{ end -}}
{{-       if or (has "POSTGRESQL_USER" $names) (has "POSTGRESQL_ADMIN_PASSWORD" $names) (contains "rhel9/postgresql" (toString .image)) -}}
{{-         $f = "rhel" -}}
{{-       else if or (has "PGDATA" $names) (has "POSTGRES_USER" $names) -}}
{{-         $f = "alpine" -}}
{{-       end -}}
{{-     end -}}
{{-   end -}}
{{- end -}}
{{- $f -}}
{{- end }}

{{- define "axera.kafkaTierRecorded" -}}
{{- $ns := .Values.global.namespace -}}
{{- $s := lookup "v1" "Secret" $ns (include "axera.kafkaSecretName" .) | default dict -}}
{{- $ann := ($s.metadata | default dict).annotations | default dict -}}
{{- $t := index $ann "platform.axerasecurity.com/kafka-tier" | default (index $ann "axera.io/kafka-tier") | default "" | toString -}}
{{- if not (has $t (list "internal" "external")) -}}
{{-   $t = "" -}}
{{-   $d := $s.data | default dict -}}
{{-   $bs := index $d "Kafka__BootstrapServers" | default (index $d "KafkaServer") | default "" | b64dec | trim -}}
{{-   if $bs -}}
{{-     $host := regexReplaceAll `:[0-9]+$` (regexFind `^[^,]+` $bs | trim) "" | lower -}}
{{-     $t = ternary "internal" "external" (or (eq $host "kafka") (eq $host (printf "kafka.%s" $ns)) (hasPrefix (printf "kafka.%s.svc" $ns) $host)) -}}
{{-   end -}}
{{- end -}}
{{- $t -}}
{{- end }}

{{/* =========================================================================
     Health probes of a product container: startup, readiness and liveness.
     Usage: {{ include "axera.healthProbes" (dict "port" 8080 "path" "/healthz" "ctx" .) | nindent 10 }}
     The kind follows operands.v1330 unless probes.mode names one:
       http: httpGet <path> (/healthz is the first middleware of every service).
       tcp:  tcpSocket on the same port, same budgets (for images before v13.3.0).
========================================================================= */}}
{{- define "axera.healthProbes" -}}
{{- $mode := (.ctx.Values.probes | default dict).mode | default (ternary "http" "tcp" (eq (toString ((.ctx.Values.operands | default dict).v1330)) "true")) -}}
{{- if not (has $mode (list "http" "tcp")) -}}
{{- fail (printf "probes.mode must be http or tcp, not %q" $mode) -}}
{{- end -}}
{{- $handler := printf "tcpSocket: { port: %v }" .port -}}
{{- if eq $mode "http" -}}
{{- $handler = printf "httpGet: { path: %s, port: %v }" .path .port -}}
{{- end -}}
startupProbe:
  {{ $handler }}
  periodSeconds: 5
  timeoutSeconds: 5
  failureThreshold: 60
readinessProbe:
  {{ $handler }}
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
livenessProbe:
  {{ $handler }}
  {{- include "axera.livenessBudget" .ctx | nindent 2 }}
{{- end }}

{{/* The liveness budget (probes.liveness): every 20 s, a 10 s timeout, restart after 15
     failures = 5 minutes. Usage: {{- include "axera.livenessBudget" . | nindent <n> }} */}}
{{- define "axera.livenessBudget" -}}
{{- $l := (.Values.probes | default dict).liveness | default dict -}}
periodSeconds: {{ $l.periodSeconds | default 20 }}
timeoutSeconds: {{ $l.timeoutSeconds | default 10 }}
failureThreshold: {{ $l.failureThreshold | default 15 }}
{{- end }}

{{/* =========================================================================
     Pod placement of one component (scheduling.<component> over scheduling.default, field by
     field). Off OpenShift global.archNodeSelector (auto) adds kubernetes.io/arch: amd64 to the
     nodeSelector unless the selector already names an architecture: the product images are
     built for amd64 only. Renders nothing while nothing is set.
     Usage: {{- with (include "axera.scheduling" (dict "component" "api" "ctx" .) | trim) }}{{ . | nindent <n> }}{{- end }}
========================================================================= */}}
{{- define "axera.archNodeSelector" -}}
{{- $raw := .Values.global.archNodeSelector -}}
{{- $v := "auto" -}}
{{- if kindIs "bool" $raw }}{{ $v = toString $raw }}{{ else if $raw }}{{ $v = lower (toString $raw) }}{{ end -}}
{{- if not (has $v (list "auto" "true" "false")) -}}
{{- fail (printf "global.archNodeSelector must be auto, true or false, not %q" $v) -}}
{{- end -}}
{{- if or (eq $v "true") (and (eq $v "auto") (not (include "axera.isOpenShift" .))) -}}true{{- end -}}
{{- end }}

{{- define "axera.scheduling" -}}
{{- $s := .ctx.Values.scheduling | default dict -}}
{{- $d := $s.default | default dict -}}
{{- $c := index $s .component | default dict -}}
{{- $ns := deepCopy ($c.nodeSelector | default $d.nodeSelector | default dict) -}}
{{- if and (include "axera.archNodeSelector" .ctx) (not (hasKey $ns "kubernetes.io/arch")) -}}
{{- $_ := set $ns "kubernetes.io/arch" "amd64" -}}
{{- end -}}
{{- with $ns }}
nodeSelector: {{- toYaml . | nindent 2 }}
{{- end }}
{{- with ($c.affinity | default $d.affinity) }}
affinity: {{- toYaml . | nindent 2 }}
{{- end }}
{{- with ($c.tolerations | default $d.tolerations) }}
tolerations: {{- toYaml . | nindent 2 }}
{{- end }}
{{- with ($c.priorityClassName | default $d.priorityClassName) }}
priorityClassName: {{ . | quote }}
{{- end }}
{{- end }}

{{/* =========================================================================
     Axera's own ServiceAccount envs on the api and radar containers.
     operands.v1330=true: AXERA_LOCAL_SERVICE_ACCOUNTS = this install's own identities (count only
       on the cluster Axera runs on), AXERA_OWN_SERVICE_ACCOUNTS = app.ownServiceAccounts alone.
     operands.v1330=false: AXERA_OWN_SERVICE_ACCOUNTS = <ns>:axera-sa,<ns>:axera-integration-sa
       plus app.ownServiceAccounts.
========================================================================= */}}
{{- define "axera.ownServiceAccountEnv" -}}
{{- $ns := .Values.global.namespace -}}
{{- $own := list -}}
{{- with .Values.app.ownServiceAccounts -}}
{{- if kindIs "string" . -}}
{{- $own = splitList "," . -}}
{{- else -}}
{{- $own = . -}}
{{- end -}}
{{- end -}}
{{- $clean := list -}}
{{- range $own -}}
{{- if trim (toString .) -}}
{{- $clean = append $clean (trim (toString .)) -}}
{{- end -}}
{{- end -}}
{{- $local := list (printf "%s:axera-sa" $ns) (printf "%s:axera-integration-sa" $ns) -}}
{{- if eq (toString ((.Values.operands | default dict).v1330)) "true" }}
{{- with ((.Values.operator | default dict).serviceAccount) }}{{ if not (has . $local) }}{{ $local = append $local . }}{{ end }}{{ end }}
- { name: AXERA_LOCAL_SERVICE_ACCOUNTS, value: {{ join "," $local | quote }} }
- { name: AXERA_OWN_SERVICE_ACCOUNTS, value: {{ join "," $clean | quote }} }
{{- else }}
- { name: AXERA_OWN_SERVICE_ACCOUNTS, value: {{ join "," (concat $local $clean) | quote }} }
{{- end }}
{{- end }}

{{/* =========================================================================
     Kafka bootstrap servers: external → kafka.bootstrapServers, internal → kafka:9092.
========================================================================= */}}
{{- define "axera.kafkaBootstrap" -}}
{{- if .Values.kafka.external -}}
{{- .Values.kafka.bootstrapServers -}}
{{- else -}}
kafka:9092
{{- end -}}
{{- end }}

{{/* Kafka SecurityProtocol: SaslSsl for an external broker, Plaintext in-cluster, unless set. */}}
{{- define "axera.kafkaSecurityProtocol" -}}
{{- if .Values.kafka.external -}}
{{- default "SaslSsl" .Values.kafka.securityProtocol -}}
{{- else -}}
{{- default "Plaintext" .Values.kafka.securityProtocol -}}
{{- end -}}
{{- end }}

{{/* "true" when kafka-ui is deployed (kafka.enableUI with the in-cluster broker). */}}
{{- define "axera.kafkaUiEnabled" -}}
{{- if and (not .Values.kafka.external) .Values.kafka.enableUI -}}
true
{{- end -}}
{{- end }}

{{/* AI model base URL: external → ai.baseUrl, internal → the in-cluster model server Service
     (its name is kept for compatibility: AI settings saved by earlier releases name it). */}}
{{- define "axera.aiBaseUrl" -}}
{{- if .Values.ai.external -}}
{{- .Values.ai.baseUrl -}}
{{- else -}}
http://ollama:11434
{{- end -}}
{{- end }}

{{/* =========================================================================
     checksum/config for a pod template: sha256 of the data of the named ConfigMaps as
     templates/11-configmaps.yaml renders them, so a values change that rewrites a ConfigMap
     rolls the pods that read it. Only data/binaryData are hashed (a chart-version bump must not
     roll the pods). A name the file no longer renders fails the render.
     Usage: include "axera.configMapChecksum" (dict "ctx" $ "names" (list "axera-app-config"))
========================================================================= */}}
{{- define "axera.configMapChecksum" -}}
{{- $rendered := include (print .ctx.Template.BasePath "/11-configmaps.yaml") .ctx -}}
{{- $picked := dict -}}
{{- range $doc := regexSplit "(?m)^---[ \\t]*$" $rendered -1 -}}
{{- $obj := fromYaml $doc -}}
{{- if hasKey $obj "Error" -}}
{{- fail (printf "axera.configMapChecksum: 11-configmaps.yaml does not parse: %s" (get $obj "Error")) -}}
{{- end -}}
{{- $name := dig "metadata" "name" "" $obj -}}
{{- if and (eq (get $obj "kind") "ConfigMap") (has $name $.names) -}}
{{- $_ := set $picked $name (pick $obj "data" "binaryData") -}}
{{- end -}}
{{- end -}}
{{- if ne (len $picked) (len .names) -}}
{{- fail (printf "axera.configMapChecksum: 11-configmaps.yaml renders %d of the ConfigMaps %v" (len $picked) .names) -}}
{{- end -}}
{{- toJson $picked | sha256sum -}}
{{- end }}

{{/* checksum/secret for a pod template: sha256 of the VALUES that feed the chart's Secrets (not of
     the rendered Secrets, whose generated parts differ on every render without a cluster). The
     pods read the Secrets as environment variables, fixed at container start, so a rotation through
     values (app.internalToken, the Kafka SASL credentials, a mesh ingest token, ...) must roll them.
     Generated values are read back on upgrade and never change, so they never roll anything.
     Secrets you manage yourself (secrets.existingSecrets, secrets.create=false) are not seen here:
     restart the Deployments after rotating those. */}}
{{- define "axera.secretValuesChecksum" -}}
{{- $v := dict
    "pg" (pick .Values.postgres "user" "password" "appDbName" "radarDbName" "appDbConnString" "radarConnString" "external")
    "app" (pick .Values.app "accessTokenSecret" "encryptionKey" "encryptionIV" "secretsEncryptionKey" "adminUsername" "adminEmail" "adminPassword" "internalToken")
    "kafka" (pick .Values.kafka "external" "bootstrapServers" "securityProtocol" "saslMechanism" "saslUsername" "saslPassword" "caCert")
    "mesh" ((.Values.meshMonitoring).ingestTokens | default dict)
    "secrets" (.Values.secrets | default dict) -}}
{{- toJson $v | sha256sum -}}
{{- end }}

{{/* The newest EF migration the chart's app / Radar SQL carries, read from that SQL. */}}
{{- define "axera.newestAppMigration" -}}
{{- regexFindAll "'[0-9]{14}_[A-Za-z0-9_]+'" (.Files.Get "sql/app-init.sql") -1 | sortAlpha | last | trimAll "'" -}}
{{- end }}

{{- define "axera.newestRadarMigration" -}}
{{- regexFindAll "'[0-9]{14}_[A-Za-z0-9_]+'" (.Files.Get "sql/radar-init.sql") -1 | sortAlpha | last | trimAll "'" -}}
{{- end }}

{{/* =========================================================================
     wait-for-db initContainer (in-cluster PostgreSQL only). Waits until the NEWEST migration of
     this chart is in __EFMigrationsHistory, so a new pod never runs ahead of the migrate Job.
     Usage:
       initContainers:
         {{- include "axera.waitForDb" . | nindent 8 }}
========================================================================= */}}
{{- define "axera.waitForDb" -}}
{{- if not .Values.postgres.external }}
{{- $migration := include "axera.newestAppMigration" . }}
{{- $dbSecret := include "axera.dbSecretName" . }}
- name: wait-for-db-migrations
  image: {{ include "axera.postgresImage" . }}
  {{- with include "axera.pgClientSecurityContext" . }}
  {{- . | nindent 2 }}
  {{- end }}
  {{- with (.Values.resources).initContainers }}
  resources: {{- toYaml . | nindent 4 }}
  {{- end }}
  # User and database come from the db Secret, like the server and the migrate Job, so a Secret
  # of your own (secrets.existingSecrets.db) with another POSTGRES_USER / APP_DB_NAME is waited on
  # correctly.
  env:
    - name: PGPASSWORD
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: POSTGRES_PASSWORD } }
    - name: PGUSER
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: POSTGRES_USER } }
    - name: APP_DB
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: APP_DB_NAME } }
  command:
    - sh
    - -c
    - |
      set -e
      until pg_isready -h postgres-app; do sleep 2; done
      n=0
      until out=$(psql -h postgres-app -d "$APP_DB" -tAc \
        "SELECT 1 FROM \"__EFMigrationsHistory\" WHERE \"MigrationId\" = '{{ $migration }}'" 2>&1) && echo "$out" | grep -qx 1; do
        if [ $((n % 12)) -eq 0 ]; then echo "[wait] $(echo "$out" | head -n 1)"; fi
        n=$((n + 1))
        echo "[wait] migration {{ $migration }} not applied yet (db-migrate Job), sleeping 5s..."; sleep 5
      done
      echo "[wait] DB schema ready ({{ $migration }})."
{{- end }}
{{- end }}

{{/* Radar's wait-for-db initContainer: the newest App AND the newest Radar migration. */}}
{{- define "axera.waitForRadarDb" -}}
{{- if not .Values.postgres.external }}
{{- $appMigration := include "axera.newestAppMigration" . }}
{{- $radarMigration := include "axera.newestRadarMigration" . }}
{{- $dbSecret := include "axera.dbSecretName" . }}
- name: wait-for-db-migrations
  image: {{ include "axera.postgresImage" . }}
  {{- with include "axera.pgClientSecurityContext" . }}
  {{- . | nindent 2 }}
  {{- end }}
  {{- with (.Values.resources).initContainers }}
  resources: {{- toYaml . | nindent 4 }}
  {{- end }}
  env:
    - name: PGPASSWORD
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: POSTGRES_PASSWORD } }
    - name: PGUSER
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: POSTGRES_USER } }
    - name: APP_DB
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: APP_DB_NAME } }
    - name: RADAR_DB
      valueFrom: { secretKeyRef: { name: {{ $dbSecret }}, key: RADAR_DB_NAME } }
  command:
    - sh
    - -c
    - |
      set -e
      until pg_isready -h postgres-app; do sleep 2; done
      until pg_isready -h postgres-radar; do sleep 2; done
      n=0
      until out=$(psql -h postgres-app -d "$APP_DB" -tAc \
        "SELECT 1 FROM \"__EFMigrationsHistory\" WHERE \"MigrationId\" = '{{ $appMigration }}'" 2>&1) && echo "$out" | grep -qx 1; do
        if [ $((n % 12)) -eq 0 ]; then echo "[wait] $(echo "$out" | head -n 1)"; fi
        n=$((n + 1))
        echo "[wait] app migration {{ $appMigration }} not applied yet (db-migrate Job), sleeping 5s..."; sleep 5
      done
      n=0
      until out=$(psql -h postgres-radar -d "$RADAR_DB" -tAc \
        "SELECT 1 FROM \"__EFMigrationsHistory\" WHERE \"MigrationId\" = '{{ $radarMigration }}'" 2>&1) && echo "$out" | grep -qx 1; do
        if [ $((n % 12)) -eq 0 ]; then echo "[wait] $(echo "$out" | head -n 1)"; fi
        n=$((n + 1))
        echo "[wait] radar migration {{ $radarMigration }} not applied yet (radar-db-migrate Job), sleeping 5s..."; sleep 5
      done
      echo "[wait] Both DB schemas ready ({{ $appMigration }}, {{ $radarMigration }})."
{{- end }}
{{- end }}

{{/* =========================================================================
     External PostgreSQL: turn the Npgsql connection string in $PG_CONNSTR into the libpq
     environment psql reads (shell snippet for the migrate and trial-bootstrap Jobs). Keys match
     the way Npgsql matches them (case-insensitive, spaces ignored, with its synonyms). Values are
     split on ';' (no ';' in the password). SslMode becomes PGSSLMODE; the verify modes check the
     server certificate against postgres.caSecret when set (PGSSLROOTCERT on the container),
     else the image's system CA bundle: PGSSLROOTCERT=system for VerifyFull (libpq 16 or newer);
     for VerifyCA libpq refuses "system", so the bundle file of the alpine or rhel image is named.
     Usage (inside a `- |` block):  {{- include "axera.pgConnStrEnv" . | nindent 14 }}
========================================================================= */}}
{{- define "axera.pgConnStrEnv" -}}
# Npgsql connection string -> PGHOST, PGPORT, PGDATABASE, PGUSER, PGPASSWORD, PGSSLMODE.
IFS=';'
for kv in $PG_CONNSTR; do
  k=$(printf '%s' "${kv%%=*}" | tr -d ' \t' | tr 'A-Z' 'a-z')
  v="${kv#*=}"
  case "$k" in
    host|server)              export PGHOST="$v" ;;
    port)                     export PGPORT="$v" ;;
    database|db)              export PGDATABASE="$v" ;;
    username|userid|uid)      export PGUSER="$v" ;;
    password|pwd|psw)         export PGPASSWORD="$v" ;;
    sslmode)
      m=$(printf '%s' "$v" | tr -d ' \t-' | tr 'A-Z' 'a-z')
      case "$m" in
        disable|allow|prefer|require) export PGSSLMODE="$m" ;;
        verifyca)   export PGSSLMODE=verify-ca ;;
        verifyfull) export PGSSLMODE=verify-full ;;
        *) echo "SslMode=$v in the connection string is not one of Disable, Allow, Prefer, Require, VerifyCA, VerifyFull." >&2; exit 1 ;;
      esac ;;
  esac
done
unset IFS
case "${PGSSLMODE:-}" in
  verify-full) export PGSSLROOTCERT="${PGSSLROOTCERT:-system}" ;;
  verify-ca)
    if [ -z "${PGSSLROOTCERT:-}" ]; then
      for f in /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt; do
        if [ -f "$f" ]; then export PGSSLROOTCERT="$f"; break; fi
      done
    fi ;;
esac
{{- end }}

{{/* postgres.caSecret on a migrate / bootstrap Job: the env and mount (container level) and the
     volume (pod level). The Secret holds the PEM CA under the key ca.crt. */}}
{{- define "axera.pgCaEnv" -}}
{{- if .Values.postgres.caSecret }}
- { name: PGSSLROOTCERT, value: /etc/axera/pg-ca/ca.crt }
{{- end }}
{{- end }}

{{- define "axera.pgCaMount" -}}
{{- if .Values.postgres.caSecret }}
volumeMounts:
  - { name: pg-ca, mountPath: /etc/axera/pg-ca, readOnly: true }
{{- end }}
{{- end }}

{{/* postgres.caSecret on the product pods that open database connections (api, radar,
     networkpolicywatcher, allowdropmonitor), external PostgreSQL only. The database driver reads
     PGSSLROOTCERT as its default root certificate. Each renders one list item (or nothing):
       env:          {{- include "axera.pgCaAppEnv" . | nindent 12 }}
       volumeMounts: {{- include "axera.pgCaAppMount" . | nindent 12 }}
       volumes:      {{- include "axera.pgCaAppVolume" . | nindent 8 }} */}}
{{- define "axera.pgCaAppEnv" -}}
{{- if and .Values.postgres.external .Values.postgres.caSecret }}
- { name: PGSSLROOTCERT, value: /etc/axera/pg-ca/ca.crt }
{{- end }}
{{- end }}

{{- define "axera.pgCaAppMount" -}}
{{- if and .Values.postgres.external .Values.postgres.caSecret }}
- { name: pg-ca, mountPath: /etc/axera/pg-ca, readOnly: true }
{{- end }}
{{- end }}

{{- define "axera.pgCaAppVolume" -}}
{{- if and .Values.postgres.external .Values.postgres.caSecret }}
- name: pg-ca
  secret: { secretName: {{ .Values.postgres.caSecret }}, items: [{ key: ca.crt, path: ca.crt }] }
{{- end }}
{{- end }}

{{- define "axera.pgCaVolume" -}}
{{- if .Values.postgres.caSecret }}
volumes:
  - name: pg-ca
    secret: { secretName: {{ .Values.postgres.caSecret }}, items: [{ key: ca.crt, path: ca.crt }] }
{{- end }}
{{- end }}

{{/* =========================================================================
     Kafka topic provisioning (kafka.clusters / sharedTopics / topicProvisioning).
========================================================================= */}}

{{/* The mode Radar runs in (Kafka__TopicProvisioning__Mode): the value's, else Create with the
     internal Kafka and Verify with an external one. Strimzi provisions through KafkaTopics
     (templates/32-kafka-topics.yaml), so Radar only verifies. */}}
{{- define "axera.kafkaProvisioningMode" -}}
{{- $tp := .Values.kafka.topicProvisioning | default dict -}}
{{- $mode := $tp.mode | default "" -}}
{{- if eq $mode "Strimzi" -}}
{{- if not (dig "strimzi" "clusterName" "" $tp) -}}
{{- fail "kafka.topicProvisioning.mode Strimzi needs kafka.topicProvisioning.strimzi.clusterName (the Kafka resource the KafkaTopics belong to)" -}}
{{- end -}}
Verify
{{- else if has $mode (list "Create" "Verify" "Off") -}}
{{- $mode -}}
{{- else if $mode -}}
{{- fail (printf "kafka.topicProvisioning.mode %q is not one of Create, Verify, Off, Strimzi" $mode) -}}
{{- else if .Values.kafka.external -}}
Verify
{{- else -}}
Create
{{- end -}}
{{- end }}

{{/* The effective topic catalogue as JSON: a list of {topic, lane, derived}, built the way
     Radar's own catalogue builds it:
     - per lane, the explicit list (kafka.topics, ingressTopics, interClusterTopics, processTopics,
       dnsTopics) first; then, only with kafka.clusters, per cluster c the topics c, c-process and
       c-dns and the shared external-flows / ingress-flows / intercluster-flows unless
       kafka.sharedTopics.* is false. A derived topic its lane already lists explicitly is skipped.
     - the east-west lane never holds external-flows, a cross-cluster topic, an ingress topic or
       ingress-flows.
     - with the ingress lane switched off (kafka.ingress.enabled false) the Ingress lane is left out.
     - each topic once, in lane order Flows, External, Ingress, InterCluster, Process, Dns. */}}
{{- define "axera.kafkaTopicCatalog" -}}
{{- $k := .Values.kafka -}}
{{- $shared := $k.sharedTopics | default dict -}}
{{- $clusters := list -}}
{{- range ($k.clusters | default list) -}}
{{- $c := . | toString | trim -}}
{{- if and $c (not (has $c $clusters)) }}{{ $clusters = append $clusters $c }}{{ end -}}
{{- end -}}
{{- $flows := list -}}
{{- $flowNames := list -}}
{{- range ($k.topics | default list) -}}
{{- $flows = append $flows (dict "topic" (.topic | default "" | toString) "derived" false) -}}
{{- $flowNames = append $flowNames (.topic | default "" | toString) -}}
{{- end -}}
{{- $ingress := list -}}
{{- $ingressNames := list -}}
{{- range ($k.ingressTopics | default list) -}}
{{- if (.topic | default "" | toString | trim) -}}
{{- $ingress = append $ingress (dict "topic" (.topic | toString) "derived" false) -}}
{{- $ingressNames = append $ingressNames (.topic | toString) -}}
{{- end -}}
{{- end -}}
{{- $inter := list -}}
{{- $interNames := list -}}
{{- range ($k.interClusterTopics | default list) -}}
{{- $inter = append $inter (dict "topic" (.topic | default "" | toString) "derived" false) -}}
{{- $interNames = append $interNames (.topic | default "" | toString) -}}
{{- end -}}
{{- $process := list -}}
{{- $processNames := list -}}
{{- range ($k.processTopics | default list) -}}
{{- $process = append $process (dict "topic" (.topic | default "" | toString) "derived" false) -}}
{{- $processNames = append $processNames (.topic | default "" | toString) -}}
{{- end -}}
{{- $dns := list -}}
{{- $dnsNames := list -}}
{{- range ($k.dnsTopics | default list) -}}
{{- $dns = append $dns (dict "topic" (.topic | default "" | toString) "derived" false) -}}
{{- $dnsNames = append $dnsNames (.topic | default "" | toString) -}}
{{- end -}}
{{- if $clusters -}}
{{- range $c := $clusters -}}
{{- if not (has $c $flowNames) -}}
{{- $flows = append $flows (dict "topic" $c "derived" true) -}}
{{- $flowNames = append $flowNames $c -}}
{{- end -}}
{{- $pt := printf "%s-process" $c -}}
{{- if not (has $pt $processNames) -}}
{{- $process = append $process (dict "topic" $pt "derived" true) -}}
{{- $processNames = append $processNames $pt -}}
{{- end -}}
{{- $dt := printf "%s-dns" $c -}}
{{- if not (has $dt $dnsNames) -}}
{{- $dns = append $dns (dict "topic" $dt "derived" true) -}}
{{- $dnsNames = append $dnsNames $dt -}}
{{- end -}}
{{- end -}}
{{- if and (ne (toString (dig "external" true $shared)) "false") (not (has "external-flows" $flowNames)) -}}
{{- $flows = append $flows (dict "topic" "external-flows" "derived" true) -}}
{{- $flowNames = append $flowNames "external-flows" -}}
{{- end -}}
{{- if and (ne (toString (dig "ingress" true $shared)) "false") (not (has "ingress-flows" $ingressNames)) -}}
{{- $ingress = append $ingress (dict "topic" "ingress-flows" "derived" true) -}}
{{- $ingressNames = append $ingressNames "ingress-flows" -}}
{{- end -}}
{{- if and (ne (toString (dig "interCluster" true $shared)) "false") (not (has "intercluster-flows" $interNames)) -}}
{{- $inter = append $inter (dict "topic" "intercluster-flows" "derived" true) -}}
{{- $interNames = append $interNames "intercluster-flows" -}}
{{- end -}}
{{- end -}}
{{- $excluded := append $ingressNames "ingress-flows" -}}
{{- $ingressOn := ne (toString (dig "enabled" true ($k.ingress | default dict))) "false" -}}
{{- $lanes := list -}}
{{- $eastWest := list -}}
{{- $external := list -}}
{{- range $flows -}}
{{- if eq .topic "external-flows" -}}
{{- $external = append $external . -}}
{{- else if and (not (has .topic $interNames)) (not (has .topic $excluded)) -}}
{{- $eastWest = append $eastWest . -}}
{{- end -}}
{{- end -}}
{{- $lanes = append $lanes (list "Flows" $eastWest) -}}
{{- $lanes = append $lanes (list "External" $external) -}}
{{- if $ingressOn }}{{ $lanes = append $lanes (list "Ingress" $ingress) }}{{ end -}}
{{- $lanes = append $lanes (list "InterCluster" $inter) -}}
{{- $lanes = append $lanes (list "Process" $process) -}}
{{- $lanes = append $lanes (list "Dns" $dns) -}}
{{- $seen := dict -}}
{{- $out := list -}}
{{- range $lanes -}}
{{- $lane := index . 0 -}}
{{- range (index . 1) -}}
{{- if and (trim .topic) (not (hasKey $seen .topic)) -}}
{{- $_ := set $seen .topic true -}}
{{- $out = append $out (dict "topic" .topic "lane" $lane "derived" .derived) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- toJson $out -}}
{{- end }}

{{/* The profile of a lane as JSON {partitions, retentionHours, retentionBytes}:
     kafka.topicProvisioning.profiles.<lane> over the defaults (flows 3 partitions and 10 GiB per
     partition, every other lane 1 and 2 GiB; 2 hours, Radar's own default). Call with
     (list . "Flows"). */}}
{{- define "axera.kafkaTopicProfile" -}}
{{- $ctx := index . 0 -}}
{{- $lane := index . 1 -}}
{{- $key := dict "Flows" "flows" "External" "external" "Ingress" "ingress" "InterCluster" "interCluster" "Process" "process" "Dns" "dns" | dig $lane "" -}}
{{- $p := dig "profiles" $key dict ($ctx.Values.kafka.topicProvisioning | default dict) -}}
{{- $parts := 1 -}}
{{- $bytes := 2147483648 -}}
{{- if eq $lane "Flows" }}{{ $parts = 3 }}{{ $bytes = 10737418240 }}{{ end -}}
{{- with $p.partitions }}{{ $parts = . }}{{ end -}}
{{- $hours := $p.retentionHours | default 2 -}}
{{- with $p.retentionBytes }}{{ $bytes = . }}{{ end -}}
{{- dict "partitions" ($parts | int64) "retentionHours" ($hours | int64) "retentionBytes" ($bytes | int64) | toJson -}}
{{- end }}

{{/* A KafkaTopic object name for a Kafka topic: a DNS-1123 subdomain, suffixed with a hash of
     the real name when it had to be cleaned; spec.topicName always carries the real name. */}}
{{- define "axera.kafkaTopicObjectName" -}}
{{- $clean := regexReplaceAll "[^a-z0-9.-]+" (lower .) "-" | trunc 200 | trimAll "-." -}}
{{- if eq $clean . -}}
{{- $clean -}}
{{- else -}}
{{- printf "%s-%s" ($clean | default "topic") (sha256sum . | trunc 8) -}}
{{- end -}}
{{- end }}

{{/* "true" when Radar and the API serve /metrics on port 9090 (monitoring.enabled, default on). */}}
{{- define "axera.metricsEnabled" -}}
{{- if ne (toString (dig "enabled" true (.Values.monitoring | default dict))) "false" }}true{{ end -}}
{{- end }}

{{/* "true" when the ServiceMonitor / PrometheusRule can be applied: metrics on and the cluster
     serves the Prometheus Operator's monitoring.coreos.com/v1. */}}
{{- define "axera.prometheusOperator" -}}
{{- if and (include "axera.metricsEnabled" .) (.Capabilities.APIVersions.Has "monitoring.coreos.com/v1") }}true{{ end -}}
{{- end }}

{{/* The namespaces whose Prometheus may scrape port 9090 (with networkPolicies.enabled):
     monitoring.scrapeNamespaces, else per distribution. */}}
{{- define "axera.scrapeNamespaces" -}}
{{- $l := (.Values.monitoring | default dict).scrapeNamespaces | default list -}}
{{- if not $l -}}
{{- $l = get (dict "openshift" (list "openshift-user-workload-monitoring") "rke2" (list "cattle-monitoring-system") "anthos" (list "gmp-system")) (include "axera.distribution" .) | default (list "monitoring") -}}
{{- end -}}
{{- toJson $l -}}
{{- end }}

{{/* The metrics port's env for Radar and the API. */}}
{{- define "axera.metricsEnv" -}}
- { name: Metrics__Enabled, value: {{ if include "axera.metricsEnabled" . }}"true"{{ else }}"false"{{ end }} }
- { name: Metrics__Port, value: "9090" }
{{- end }}
