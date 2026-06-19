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
     Frontend Route hostname.
     Priority: explicit host > derived frontend-<ns>.<clusterDomain> >
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

{{/* =========================================================================
     Image full path: <registry>/<repo>:<tag>
     Each image may set its own `registry` (e.g. registry.redhat.io for the
     Red Hat-certified Postgres); otherwise global.imageRegistry is used.
     Usage: {{ include "axera.image" (dict "img" .Values.images.api "ctx" .) }}
========================================================================= */}}
{{- define "axera.image" -}}
{{- $reg := .img.registry | default .ctx.Values.global.imageRegistry -}}
{{- printf "%s/%s:%s" $reg .img.repo .img.tag -}}
{{- end }}

{{/* =========================================================================
     Postgres connection strings.
     external=true  → use values.postgres.{appDb,radar}ConnString verbatim
     external=false → build from values.postgres.{user,password} + service DNS
========================================================================= */}}
{{- define "axera.appDbConnString" -}}
{{- if .Values.postgres.external -}}
{{- .Values.postgres.appDbConnString -}}
{{- else -}}
{{- printf "Host=postgres-app;Port=5432;Database=%s;Username=%s;Password=%s" .Values.postgres.appDbName .Values.postgres.user .Values.postgres.password -}}
{{- end -}}
{{- end }}

{{- define "axera.radarDbConnString" -}}
{{- if .Values.postgres.external -}}
{{- .Values.postgres.radarConnString -}}
{{- else -}}
{{- printf "Host=postgres-radar;Port=5432;Database=%s;Username=%s;Password=%s" .Values.postgres.radarDbName .Values.postgres.user .Values.postgres.password -}}
{{- end -}}
{{- end }}

{{/* =========================================================================
     Kafka bootstrap servers.
     external=true  → values.kafka.bootstrapServers
     external=false → cluster-internal kafka:9092
========================================================================= */}}
{{- define "axera.kafkaBootstrap" -}}
{{- if .Values.kafka.external -}}
{{- .Values.kafka.bootstrapServers -}}
{{- else -}}
kafka:9092
{{- end -}}
{{- end }}

{{/* =========================================================================
     Kafka SecurityProtocol — defaults differ by mode.
========================================================================= */}}
{{- define "axera.kafkaSecurityProtocol" -}}
{{- if .Values.kafka.external -}}
{{- default "SaslSsl" .Values.kafka.securityProtocol -}}
{{- else -}}
{{- default "Plaintext" .Values.kafka.securityProtocol -}}
{{- end -}}
{{- end }}

{{/* =========================================================================
     Whether kafka-ui Route should be created.
     Disabled if kafka.external (no internal kafka-ui deployed).
========================================================================= */}}
{{- define "axera.kafkaUiEnabled" -}}
{{- if and (not .Values.kafka.external) .Values.kafka.enableUI -}}
true
{{- end -}}
{{- end }}

{{/* =========================================================================
     AI assistant base URL.
     external=true  → values.ai.baseUrl verbatim (customer endpoint)
     external=false → cluster-internal ollama:11434
========================================================================= */}}
{{- define "axera.aiBaseUrl" -}}
{{- if .Values.ai.external -}}
{{- .Values.ai.baseUrl -}}
{{- else -}}
http://ollama:11434
{{- end -}}
{{- end }}

{{/* =========================================================================
     wait-for-db initContainer (cluster-internal Postgres only).
     For external Postgres, app pods skip waiting — assume customer DB is up.
     Usage:
       initContainers:
         {{- include "axera.waitForDb" . | nindent 8 }}
========================================================================= */}}
{{- define "axera.waitForDb" -}}
{{- if not .Values.postgres.external }}
- name: wait-for-db-migrations
  image: {{ include "axera.image" (dict "img" .Values.images.postgres "ctx" .) }}
  env:
    - name: PGPASSWORD
      valueFrom: { secretKeyRef: { name: axera-db-secrets, key: POSTGRES_PASSWORD } }
  command:
    - sh
    - -c
    - |
      set -e
      until pg_isready -h postgres-app -U postgres; do sleep 2; done
      until psql -h postgres-app -U postgres -d {{ .Values.postgres.appDbName }} -tAc \
        "SELECT 1 FROM information_schema.tables WHERE table_schema='public' AND table_name='AspNetUsers'" 2>/dev/null | grep -q 1; do
        echo "[wait] migrations not ready, sleeping 5s..."; sleep 5
      done
      echo "[wait] DB schema ready."
{{- end }}
{{- end }}

{{- define "axera.waitForRadarDb" -}}
{{- if not .Values.postgres.external }}
- name: wait-for-db-migrations
  image: {{ include "axera.image" (dict "img" .Values.images.postgres "ctx" .) }}
  env:
    - name: PGPASSWORD
      valueFrom: { secretKeyRef: { name: axera-db-secrets, key: POSTGRES_PASSWORD } }
  command:
    - sh
    - -c
    - |
      set -e
      until pg_isready -h postgres-app -U postgres; do sleep 2; done
      until pg_isready -h postgres-radar -U postgres; do sleep 2; done
      until psql -h postgres-app -U postgres -d {{ .Values.postgres.appDbName }} -tAc \
        "SELECT 1 FROM information_schema.tables WHERE table_schema='public' AND table_name='AspNetUsers'" 2>/dev/null | grep -q 1; do sleep 5; done
      until psql -h postgres-radar -U postgres -d {{ .Values.postgres.radarDbName }} -tAc \
        "SELECT 1 FROM information_schema.tables WHERE table_schema='public' AND table_name='FlowEntries'" 2>/dev/null | grep -q 1; do sleep 5; done
      echo "[wait] Both DB schemas ready."
{{- end }}
{{- end }}
