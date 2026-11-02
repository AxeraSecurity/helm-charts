# Axera platform chart

The central Axera platform: console, API, flow analytics (Radar), policy engine, NetworkPolicy
watcher and, optionally, the MCP tool server and a local AI model. It runs on:

| Distribution | `global.distribution` | Front door by default | PostgreSQL image |
|---|---|---|---|
| OpenShift 4.12+ | `openshift` | Route | Red Hat (`rhel`) |
| k3s | `k3s` | Ingress, class `traefik` | community (`alpine`) |
| RKE2 / Rancher | `rke2` | Ingress, class `nginx` | community (`alpine`) |
| Anthos (GKE Enterprise) | `anthos` | Istio VirtualService | community (`alpine`) |
| Other Kubernetes 1.25+ | `vanilla` | Ingress, default class | community (`alpine`) |

`global.distribution: auto` (the default) detects OpenShift from its APIs and k3s, RKE2 and GKE
from a node's kubelet version. A render that cannot see the cluster (`helm template`, `--dry-run`,
Argo CD and other GitOps tools) falls back to `vanilla`: set the distribution explicitly there.
The easiest way is to start from the matching profile in `profiles/`.

The product images are built for **amd64** only. Off OpenShift every pod carries
`nodeSelector: kubernetes.io/arch: amd64` (`global.archNodeSelector`).

The agents that observe each cluster (flow agent, process sensor, packet capture) come from the
separate **axera-force** chart.

## Install shapes

| Shape | What goes where | Kafka / PostgreSQL |
|---|---|---|
| **(a) Full, one cluster** | `axera` in `axera-central` and `axera-force` in `axera` on the same cluster | in-cluster (lab, proof of concept) |
| **(b) Central + remote agents** | `axera` on one cluster, `axera-force` on every monitored cluster | your Kafka and PostgreSQL |
| **(c) Agent only** | `axera-force` on a cluster that reports to an existing platform | see the axera-force README |

The in-cluster Kafka is single-node and PLAINTEXT, advertised on its in-cluster DNS name: only
agents on the same cluster can reach it. Shape (b) needs your own Kafka.

### (a) Full, one cluster

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts && helm repo update
helm pull axera/axera --untar          # axera/profiles, axera/examples
helm pull axera/axera-force --untar    # axera-force/profiles

kubectl create namespace axera-central
kubectl label namespace axera-central pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/audit=baseline pod-security.kubernetes.io/warn=baseline
# the agent namespace: its node sensors need privileged
kubectl create namespace axera
kubectl label namespace axera pod-security.kubernetes.io/enforce=privileged \
  pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged

cp axera/examples/values-full-k3s.yaml my-full.yaml   # edit it first, see below
helm upgrade --install axera axera/axera -n axera-central --wait --timeout 15m \
  -f axera/profiles/values-k3s.yaml -f my-full.yaml

helm upgrade --install axera-force axera/axera-force -n axera \
  -f axera-force/profiles/values-k3s.yaml \
  --set clusterName=k3s-lab \
  --set kafka.bootstrapServers=kafka.axera-central.svc.cluster.local:9092 \
  --set kafka.securityProtocol=Plaintext \
  --set integration.create=false \
  --set 'capture.integrationNamespaces={axera-central}'
```

Edit `expose.frontend.host`, `kafka.clusters` and `networkPolicies.kafkaClients.cidrs` in
`my-full.yaml` (the copy of `examples/values-full-k3s.yaml`) first. On this shape the platform owns
the integration identity (`axera-central/axera-integration-sa`), so the agent chart must not create
a second one (`integration.create=false`). Register the cluster in the UI under the same name as
`clusterName` and `kafka.clusters`. `--wait` brings the platform up before the agent starts
producing (here Radar creates the topics, and the in-cluster broker does not auto-create them).
With the agent namespace created first, the platform's packet-capture Role lands in it on the first
install (created later, it needs one more `helm upgrade` of the platform).

Audit stream (optional): the agent's `auditForwarder.targetUri` is
`http://api.axera-central.svc.cluster.local:8080/api/Internal/Audit`, its `internalToken` the key
`Internal__Token` of `axera-central/axera-app-secret`, and the platform needs
`networkPolicies.apiClients.namespaces: [axera]` (the example sets it).

### (b) Central platform, remote agents

Layer `profiles/values-external-data.yaml` and a copy of `examples/values-central-external.yaml`
over the distribution profile (edit the copy, not the file inside the extracted chart):

```bash
cp axera/examples/values-central-external.yaml my-central.yaml
helm upgrade --install axera axera/axera -n axera-central \
  -f axera/profiles/values-<distribution>.yaml -f axera/profiles/values-external-data.yaml \
  -f my-central.yaml
```

Then, for each monitored cluster, in this order:

1. Create its topics on your Kafka, `<cluster>` (3 partitions) and `<cluster>-process` (1), plus
   `<cluster>-dns` with DNS visibility and `external-flows` once, all with `retention.ms=7200000`,
   and grant the agent's and the platform's users their ACLs ([Kafka topics](#kafka-topics) and the
   axera-force README, "Kafka topics and ACLs"). With an external Kafka the platform only verifies
   topics; records sent to a missing topic are dropped.
2. Create namespace `axera` with the `privileged` Pod Security labels (as in (a)).
3. Create Secrets `kafka-ca` and `kafka-sasl` in `axera` (axera-force README, "Create the Kafka Secrets").
4. Install `axera-force` with that cluster's name and your broker list in a values file (a comma
   inside `--set` splits the list), without `--create-namespace`.
5. Add the cluster to `kafka.clusters` in `my-central.yaml` and `helm upgrade` the platform with the
   same `-f` files.
6. Register it with that cluster's API URL and its `axera/axera-sa-token` token, under the same name.

The audit stream of remote clusters reaches the platform on one exact path: `routes.api.enabled` on
OpenShift (`https://<routes.api.host>/api/Internal/Audit`), `expose.auditIngest.enabled` with an
Ingress or Istio front door (`https://<expose.frontend.host>/api/Internal/Audit`).

### (c) Agent only

Install only the axera-force chart (its README) and register the cluster in the existing platform.

## Prerequisites

| | OpenShift | k3s | RKE2 / Rancher | Anthos | Vanilla |
|---|---|---|---|---|---|
| StorageClass (RWO) | default | `local-path` (built in) | **none built in**: set `global.storageClass` | `standard-rwo` | default |
| Front door | router (Routes) | Traefik (built in) | rke2-ingress-nginx (Traefik on clusters created on 1.36+) | an Istio ingress Gateway, or a LoadBalancer | an IngressClass, or a LoadBalancer |
| Pod Security | SCC created by the chart | namespace `baseline` | namespace `baseline` (the CIS profile defaults to `restricted`) | namespace `baseline` | namespace `baseline` |
| Nodes | amd64 | amd64 | amd64 | amd64 | amd64 |

Sizing of the default all-internal install: about 1.3 CPU and 3.5 GiB memory requested (memory limits
up to about 16 GiB), and about 90 GiB of ReadWriteOnce storage (PostgreSQL 2 x 20 GiB, Kafka 50 GiB,
128 MiB for the DataProtection key ring). The local AI model adds 6 GiB memory and 20 GiB storage.

### Prepare the namespace

Use your own namespace, never `axera` (the agent namespace; the chart refuses it). Create it with the
Pod Security labels: every pod of this chart passes `baseline` (the in-cluster PostgreSQL, Kafka and
AI model start as root, so `restricted` is not reachable).

```bash
kubectl create namespace axera-central
kubectl label namespace axera-central pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/audit=baseline pod-security.kubernetes.io/warn=baseline
# Anthos only: keep the namespace out of the mesh
kubectl label namespace axera-central istio-injection=disabled
```

`global.createNamespace=true` makes the chart create and own the namespace with these labels, but
`helm uninstall` then deletes the namespace with every volume in it. Helm stores the release record
before it creates the chart's objects, so the record must live in another namespace that already
exists. Do not create `axera-central` beforehand and do not pass `--create-namespace`:

```bash
helm upgrade --install axera axera/axera -n default \
  --set global.namespace=axera-central --set global.createNamespace=true -f ...
```

On OpenShift the chart creates SecurityContextConstraints `axera-scc-<namespace>` instead of the
labels (`global.createSCC`).

## Install per distribution

Every profile marks the site-specific values with `<<< FILL ... >>>`; the install is refused while
one is left. Keep the same `-f` files for every later `helm upgrade`.

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts
helm pull axera/axera --untar     # for the profiles/ and examples/ files

# OpenShift
helm upgrade --install axera axera/axera -n axera-central -f axera/profiles/values-openshift.yaml
# k3s
helm upgrade --install axera axera/axera -n axera-central -f axera/profiles/values-k3s.yaml \
  --set expose.frontend.host=axera.example.com
# RKE2 / Rancher (fill storageClass, host and the IngressClass in a copy of the profile)
helm upgrade --install axera axera/axera -n axera-central -f my-values-rke2.yaml
# Anthos with Cloud Service Mesh / Istio, or with a LoadBalancer
helm upgrade --install axera axera/axera -n axera-central -f my-values-anthos-istio.yaml
helm upgrade --install axera axera/axera -n axera-central -f my-values-anthos-lb.yaml
# Other Kubernetes (fill host and the IngressClass in a copy of the profile)
helm upgrade --install axera axera/axera -n axera-central -f my-values-vanilla.yaml
```

The release notes print the UI URL, how to read the generated admin password and the follow-ups
for your distribution. `helm test axera -n axera-central` checks that the API answers; its pod
`axera-test-connection` stays `Completed` for `kubectl logs` and is replaced on the next run.

## Exposure (`expose.type`)

| Value | What is rendered | `/api/mcp` |
|---|---|---|
| `auto` | Route on OpenShift, Istio on anthos, Ingress elsewhere | |
| `Route` | OpenShift Routes (`routes.*`); OpenShift only | yes |
| `Ingress` | Ingress `frontend` on `expose.ingress.className` (empty: `traefik` on k3s, `nginx` on RKE2, the default class elsewhere) | yes |
| `Istio` | VirtualService on `istio.virtualService.gateway`, or a Gateway the chart creates | yes |
| `LoadBalancer` | the `frontend` Service becomes type LoadBalancer (plain HTTP from the pod: terminate TLS in front) | no |
| `ClusterIP` | nothing external (`kubectl port-forward svc/frontend 3000:3000`) | no |

`expose.frontend.host` is the name users browse to. It also feeds CORS, the OAuth issuer of the
MCP sign-in and the app URL, so set it for every front door except Route (where the Route host is
used). `expose.frontend.tls` must be an unquoted `true` or `false`. With Ingress, a TLS certificate
comes from `expose.ingress.tlsSecretName` (or cert-manager annotations in
`expose.ingress.annotations`); without one the controller serves its default certificate. With
LoadBalancer the pod serves plain HTTP: terminate TLS on a load balancer in front, then set
`expose.frontend.tls=true` so the generated URLs use https. `expose.frontend.externalTrafficPolicy:
Local` keeps the client address (the anthos-lb profile sets it, see NetworkPolicies).

The vanilla and RKE2 profiles ask for `expose.ingress.className` (`kubectl get ingressclass`): most
controllers ignore an Ingress without a class when none is marked default, and clusters created on
RKE2 1.36 or newer default to Traefik (clusters upgraded to 1.36 keep rke2-ingress-nginx). On
OpenShift without a Route host, `/api/mcp` shares the frontend Route's generated host.

Remote agents post the cluster API audit stream to `/api/Internal/Audit` on the api Service. Expose
that one path with `routes.api.enabled` (OpenShift) or `expose.auditIngest.enabled` (Ingress,
Istio: an Exact-path rule on the UI host; refused with LoadBalancer and ClusterIP).

Request timeouts form a ladder: the front door (Route 330 s, Ingress and Istio 180 s) outlasts the
console proxy (150 s), which outlasts the heaviest API reads (120 s). The ingress-nginx annotations
(timeouts 180 s, body size 52m) are added unless the class is Traefik (`expose.ingress.nginxDefaults`).

### Traefik read timeout

Traefik has no per-Ingress timeout. Traefik 2.11.2 or newer, including the Traefik 3 that current
k3s and RKE2 releases bundle, reads a request for at most 60 s, which cuts slow reads and large
uploads. Raise it to 180 s with entry point flags, which every Traefik Helm chart passes through.
The Traefik chart's own `ports.<name>.transport` key exists only in newer Traefik charts; older
ones, such as the chart 27 that older k3s releases bundle, ignore it without an error.

```yaml
# k3s: name traefik; RKE2 with Traefik: name rke2-traefik
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    additionalArguments:
      - "--entrypoints.web.transport.respondingTimeouts.readTimeout=180s"
      - "--entrypoints.websecure.transport.respondingTimeouts.readTimeout=180s"
```

A list in `valuesContent` replaces the chart's list: if your HelmChartConfig already sets
`additionalArguments`, add these two lines to it. Check the result with
`kubectl -n kube-system get deploy,ds -o yaml | grep readTimeout` (Traefik runs as a Deployment on
k3s and as a DaemonSet on RKE2). Only Traefik 2.11.1 and older set no limit. Apply it unless you know the bundled Traefik is older.

With `expose.frontend.tls: true` the chart binds the Ingress to Traefik's `websecure` entry point
only, so `http://<host>` answers 404 instead of serving the UI unencrypted: browse to
`https://<host>`. For a redirect from http to https, add it under `ports.web` in the same
HelmChartConfig. It redirects every HTTP request on that entry point, for all Ingresses on the
cluster, not only Axera's. The key depends on the Traefik Helm chart your distribution bundles
(`kubectl -n kube-system get deploy,ds -L helm.sh/chart`). Use one of the three forms:

```yaml
    ports:
      web:
        # Traefik charts 25 to 33 (chart 27 on older k3s releases):
        redirectTo: { port: websecure }
        # Traefik charts before 25, instead:
        # redirectTo: websecure
        # Traefik chart 34 or newer, instead:
        # redirections: { entryPoint: { to: websecure, scheme: https, permanent: true } }
```

## Data: PostgreSQL and Kafka

### In-cluster (default)

Two PostgreSQL 16 StatefulSets (`postgres-app`, `postgres-radar`) and a single-node KRaft Kafka.
`images.postgres.flavor: auto` picks the Red Hat image on OpenShift (data in `/var/lib/pgsql/data`,
uid 26) and the community alpine image elsewhere (data in a `pgdata` subdirectory, uid 70). The two
keep their data in different layouts, so the flavour cannot change on an existing install. Size the
server with `postgres.tuning` together with `resources.postgres`. The Kafka cluster ID is kept in
ConfigMap `kafka-cluster-id`; a new install takes the fixed ID the earlier charts used, so an
upgrade finds its formatted volume. `kafka.clusterId` overrides both.

### External (production)

`profiles/values-external-data.yaml`: `postgres.external=true` with two Npgsql connection strings,
`kafka.external=true` with the brokers, `SaslSsl` and `ScramSha512`, and `app.dpKeysStore: Database`
(no volume at all). For `SslMode=VerifyCA` or `VerifyFull` against a private CA, put the CA in a
Secret under `ca.crt` and name it in `postgres.caSecret`: the migration and trial Jobs and the api,
radar, networkpolicywatcher and allowdropmonitor pods trust it (the backup Jobs the API starts do
not). Without `caSecret` the Jobs use the image's public CA bundle. The migration Jobs read
Host, Port, Database, Username, Password and SslMode from the connection strings (no `;` in the
password). With an external database, set `backup.pgImage` to a PostgreSQL image of the server's
major version (`pg_dump` must be at least as new as the server; a newer `pg_restore` fails against
an older server).

### Kafka topics

List the agent clusters by their registered names in `kafka.clusters`: Radar then consumes
`<cluster>` (flows), `<cluster>-process` and `<cluster>-dns` for each, plus the shared
`external-flows`, `ingress-flows` and `intercluster-flows`. `kafka.topicProvisioning.mode`: `Create`
(the default with the in-cluster Kafka) creates missing topics and never alters existing ones;
`Verify` (the default with an external Kafka) only checks and reports; `Strimzi` renders one
KafkaTopic per derived topic. The legacy explicit lists (`kafka.topics`, `processTopics`, ...)
still work and are merged with the derived ones. A topic named in an explicit list never gets a
KafkaTopic in `Strimzi` mode; the default `kafka.topics` names `external-flows`, so create that
one yourself (or set `kafka.topics: []` to have it rendered).

ACLs for the platform's Kafka user, per cluster `$C` (`admin.properties` holds your admin client's
settings): Read and Describe on the topics and Read on the three consumer groups; DescribeConfigs
for `Verify`, and Create as well for `Create`:

```bash
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> \
  --operation Read --operation Describe --operation DescribeConfigs \
  --topic $C --topic $C-process --topic $C-dns \
  --topic external-flows --topic ingress-flows --topic intercluster-flows
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> --operation Read \
  --group axera-radar --group axera-process --group axera-dns
```

(Two commands: older `kafka-acls.sh` accept only Read, Describe and Delete on a group and reject a
command that also asks DescribeConfigs for it.)

Groups: `axera-radar` reads the flow, `external-flows`, `ingress-flows` and `intercluster-flows`
topics, `axera-process` the process topics, `axera-dns` the DNS topics. The agent's ACLs are in the
axera-force README.

### Data tier guard

The chart records on its Secrets where the data lives (internal or external PostgreSQL and Kafka,
and the PostgreSQL image flavour). A `helm upgrade` whose values ask for something else is refused,
because the usual cause is a values file left out of the command, which would start the platform on
new, empty databases. To change it on purpose after moving the data, pass
`--set dataTier.allowChange=true` to that one command.

## Secrets

With the defaults the chart renders three Secrets and fills every blank value once, at install:

| Secret | Keys |
|---|---|
| `axera-db-secrets` | `POSTGRES_USER`, `POSTGRES_PASSWORD`, `APP_DB_NAME`, `RADAR_DB_NAME`, `APP_DB_CONNSTR`, `RADAR_DB_CONNSTR` |
| `axera-app-secret` | `AccessTokenSecret` (64+ characters), `AdminCredentials__Username`, `AdminCredentials__Email`, `AdminCredentials__Password`, `Encryption__Key` (base64, 32 bytes), `Encryption__IV` (base64, 16 bytes), `Secrets__EncryptionKey` (base64, 32 bytes: the stored cluster tokens and integration credentials), `Internal__Token` |
| `kafka-external-secret` | `KafkaServer`, `Kafka__BootstrapServers`, `Kafka__SecurityProtocol`, `Kafka__SaslMechanism`, `Kafka__SaslUsername`, `Kafka__SaslPassword`, `Kafka__SslCaLocation` (`/etc/kafka-certs/ca.crt` or empty), `ca.crt` |

Upgrades read the values back, so they never change. The Secrets, the integration ServiceAccount
and its token carry `helm.sh/resource-policy: keep`. Keep a copy of `axera-app-secret`: data
encrypted with a lost encryption key cannot be read back. `meshMonitoring.ingestTokens` renders a
fourth Secret, `axera-mesh-ingest-tokens` (an entry removed from the map is removed from it).

To bring your own, create a Secret with the same keys and name it in
`secrets.existingSecrets.db|app|kafka` (the chart then renders no Secret of that kind), or set
`secrets.create=false` and create all three under the names above. A value changed through the
chart's values restarts the pods that read it; after rotating a Secret you manage yourself, run
`kubectl -n axera-central rollout restart deploy`.

### GitOps (Argo CD, Flux with `helm template`)

Generated values, the Kafka cluster ID and the namespaced Roles rely on Helm `lookup`, which answers
empty when the chart is rendered without a cluster. There:

- create the Secrets yourself and use `secrets.existingSecrets` or `secrets.create=false`;
- optionally pin `kafka.clusterId` (22 characters, base64url of 16 bytes);
- set `integration.namespacedRoles=always` (create the agent namespace `axera` first);
- set `global.distribution` explicitly.

## NetworkPolicies

`networkPolicies.enabled` (default true) isolates the namespace for ingress: pods reach each other
inside it; the front door reaches only the published pods (`frontend`, plus `mcp` and `kafka-ui`
when published); the monitoring namespace reaches the metrics port 9090; only the API reaches the
local AI model. Egress is not restricted.

- Front door peers: on OpenShift the router's policy group. Elsewhere `networkPolicies.ingressFrom`
  (raw NetworkPolicyPeer objects); empty means any source on ports 3000/8080. The k3s profile
  narrows it to the Traefik pods; the other profiles show examples.
- Agents producing to the in-cluster Kafka run on the host network. On OpenShift the host-network
  policy group admits them. Elsewhere list the node subnet(s) and the cluster (pod) CIDR in
  `networkPolicies.kafkaClients.cidrs`; with none listed the policy admits any source on 9092 and
  the release notes say so. On dataplanes where cross-node host traffic matches no ipBlock (GKE
  Dataplane V2) set `networkPolicies.kafkaClients.unrestricted=true`.
  The anthos profiles set it.
- In-cluster API callers from other namespaces: `networkPolicies.apiClients.namespaces` (default
  none). List `axera` when the agent's audit forwarder runs on the same cluster.
- Metrics scrapers: `monitoring.scrapeNamespaces`, by default `openshift-user-workload-monitoring`,
  `cattle-monitoring-system` (RKE2), `gmp-system` (Anthos) or `monitoring`.

## Licensing

A 15-day trial is seeded at install on every distribution (`licensing.trial`). Upload the licence
under Settings > System > License. Off OpenShift a licence is not bound to a cluster ID, and the worker-node
count uses the label `node-role.kubernetes.io/worker`, which k3s, RKE2 and GKE do not set by
themselves:

```bash
kubectl label node <worker-node> node-role.kubernetes.io/worker=
```

## Registering clusters

Settings > Integrations > Connections > Kubernetes Clusters > Manage Clusters > Add Cluster, with API URL
`https://kubernetes.default.svc` and the token of the integration identity:

```bash
kubectl -n axera-central get secret axera-sa-token -o jsonpath='{.data.token}' | base64 -d; echo
```

`integration.leastPrivilege=true` binds only the read-and-policy ClusterRole and leaves out the
mesh routing writes, cluster-wide pod logs, Namespace changes and the flow-agent install from the
UI. Packet capture needs the Role the chart renders in the agent namespace `axera`
(`integration.namespacedRoles`).

## Optional components

| Key | Default | Notes |
|---|---|---|
| `mcp.enabled` | `false` | MCP tool server at `<UI URL>/api/mcp` (Route, Ingress or Istio). |
| `ai.enabled` | `false` | Local AI model for incident triage (6 GiB memory), or `ai.external=true` with your endpoint. `ai.modelSource`: `registry` (download), `image` (air-gapped) or `preloaded`. |
| `kafka.enableUI` | `false` | kafka-ui without authentication; a ClusterIP Service, reach it with port-forward. |
| `backup.storage.createPvc` | `false` | Volume for Settings > System > Backup & Restore, `backup.storage.accessMode` ReadWriteMany by default (needs an RWX StorageClass; the k3s profile sets ReadWriteOnce). A custom `pvcClaimName` or an NFS share must also be entered, identically, on that Settings page. |
| `allowDropMonitor.enabled` | `auto` | OVN-Kubernetes ACL log collector: OpenShift only. |
| `kerberos.enabled` | `false` | SPNEGO sign-in with a keytab Secret. |

## Air-gapped installs

Every image is pinned by digest; Chart.yaml lists them under `artifacthub.io/images`. Mirror them and
set `global.imageRegistry` (and `images.postgres.rhel.registry`, `images.postgresBackup.*.registry`
for the Red Hat images). `tests.image` is the helm test image. For the local AI model use
`ai.modelSource=image` with a weights image.

Red Hat certification: `profiles/values-certify.yaml` renders only certified images (in-cluster
Red Hat PostgreSQL, external Kafka, no local AI model) and sets `global.distribution=openshift`,
because an offline render would otherwise resolve to vanilla.

## Main values

| Key | Default | Meaning |
|---|---|---|
| `global.distribution` | `auto` | openshift, k3s, rke2, anthos or vanilla |
| `global.namespace` | release namespace | never `axera` |
| `global.storageClass` | `""` | default StorageClass when empty |
| `global.createSCC` | `auto` | OpenShift SCC |
| `global.archNodeSelector` | `auto` | amd64 nodeSelector off OpenShift |
| `podSecurity.hardenAppContainers` | `auto` | non-root, no capabilities, RuntimeDefault seccomp off OpenShift |
| `expose.type`, `expose.frontend.*`, `expose.ingress.*` | `auto` | the front door |
| `routes.*` | | OpenShift Routes |
| `istio.*` | | VirtualService, Gateway, Job sidecar opt-out |
| `images.postgres.flavor` | `auto` | `rhel` or `alpine` |
| `postgres.*`, `kafka.*` | in-cluster | data tier |
| `secrets.*`, `dataTier.allowChange` | | see above |
| `networkPolicies.*`, `monitoring.*` | | see above |
| `scheduling.<component>` | `{}` | nodeSelector, affinity, tolerations, priorityClassName |
| `resources.<component>` | | requests and limits of every container |

`values.yaml` documents every key; `values.schema.json` validates them.

## Upgrading

Within 3.x: `helm upgrade` with the same `-f` files as the install.

### In place: the 2.0.0 package, or 1.x outside namespace `axera`

`helm upgrade` the existing release with this chart and values in the new layout:

- Values in an earlier layout (`images.postgres.repo`, the earlier AI model image and resource
  keys, `namespace.create`, ...) are refused with the new key for each.
- If the earlier chart created the namespace (1.x `global.createNamespace=true`, 2.x
  `namespace.create=true`), the upgrade is refused until you keep it: add
  `--set global.createNamespace=true`, or run
  `kubectl annotate namespace <ns> helm.sh/resource-policy=keep` first. Otherwise Helm deletes the
  namespace, with its volumes, at the end of the upgrade.
- The 2.0.0 package and the first OpenShift Helm chart (delivered before this repository) run the
  community PostgreSQL image, on OpenShift too: keep `images.postgres.flavor: alpine` there (the upgrade is
  refused otherwise).
- The in-cluster broker keeps the cluster ID its volume was formatted with. If Kafka crash-loops on
  a cluster ID mismatch after an upgrade, add `--set kafka.clusterId=MkU3OEVBNTcwNTJENDM2Qk` (the ID
  of the earlier charts); it overrides the kept ConfigMap.
- Earlier charts kept `meshMonitoring.ingestTokens` in `axera-app-secret`, and Helm never removes
  those keys. To revoke one, remove it by hand, then restart Radar:
  `kubectl -n <ns> patch secret axera-app-secret --type=json -p '[{"op":"remove","path":"/data/MeshMonitoring__IngestTokens__<cluster>"}]'`
  and `kubectl -n <ns> rollout restart deploy radar`.

### From 1.x in namespace `axera`

3.0.0 reserves `axera` for the agents, so this is a new install plus a restore of the databases.
1.x has no Backup & Restore page; dump the databases by hand:

1. Dump both databases and keep a copy of the application Secret (`<db user>`: key
   `POSTGRES_USER` of the 1.x database Secret):

   ```bash
   kubectl -n axera exec postgres-app-0 -- pg_dump -Fc -U <db user> MicrosegmentationDB > app.dump
   kubectl -n axera exec postgres-radar-0 -- pg_dump -Fc -U <db user> AxeraRadarDB > radar.dump
   kubectl -n axera get secret axera-app-secret -o yaml > axera-app-secret.yaml
   ```

2. Create that Secret in the new namespace under another name (drop the metadata other than the
   name) and add any key of the [Secrets](#secrets) table it lacks, at least
   `Secrets__EncryptionKey` (`openssl rand -base64 32`). The encryption keys must stay the same to
   read the restored data.
3. Install 3.0.0 so that nothing writes into the empty databases:
   `--set secrets.existingSecrets.app=<copy> --set postgres.runMigrations=false
   --set licensing.trial.enabled=false` (no `--wait`: the application pods wait for the
   migrations). Wait until `postgres-app-0` and `postgres-radar-0` are Ready.
4. Restore each dump into its still-empty database, as the platform's database user
   (`postgres.user`, default `postgres`):

   ```bash
   kubectl -n axera-central exec -i postgres-app-0 -- pg_restore --no-owner --no-acl -U postgres -d MicrosegmentationDB < app.dump
   kubectl -n axera-central exec -i postgres-radar-0 -- pg_restore --no-owner --no-acl -U postgres -d AxeraRadarDB < radar.dump
   ```

5. `helm upgrade` with the same files plus `--set secrets.existingSecrets.app=<copy>` and without
   the two other overrides: the migration Jobs take the schema to 3.0.0 and the pods start.
6. Register the clusters again with the new integration token. Uninstall the 1.x release before
   installing axera-force into `axera`: a 1.x release that created namespace `axera` (its default)
   deletes it on uninstall, with anything installed there in the meantime.

With an external PostgreSQL, restore into new, empty databases before the first 3.0.0 install.
Never restore over a database that 3.x has already migrated: the migrations then fail on tables
that exist.

## Uninstall

```bash
helm uninstall axera -n axera-central
```

Left behind on purpose: the three Secrets, ServiceAccount `axera-integration-sa` and its token
Secret `axera-sa-token`, PVC `axera-dp-keys`, the backup PVC the chart created, ConfigMap
`kafka-cluster-id`, any KafkaTopic it rendered, and (as with every StatefulSet) the PostgreSQL and
Kafka volumes `data-postgres-app-0`, `data-postgres-radar-0` and `data-kafka-0`, plus the local AI
model's volume (its name is kept from earlier charts). A reinstall with the same release name picks
them up. The pod of the last `helm test` stays as well. To remove everything:

```bash
kubectl -n axera-central delete pvc --all
kubectl delete namespace axera-central
```

## Troubleshooting

| Symptom | Cause |
|---|---|
| Pods Pending, "didn't match Pod's node affinity/selector" | no amd64 node (`global.archNodeSelector`) |
| PVCs Pending | no default StorageClass (RKE2): set `global.storageClass` |
| Install refused: "Replace every <<< FILL >>> placeholder" | a profile value left unfilled |
| Upgrade refused: "DATA TIER GUARD" | a values file left out of the command |
| Refused: "layout of an earlier chart" | a reused values file; the message names each new key |
| Upgrade refused: "This release owns namespace" | see [Upgrading](#upgrading) |
| UI times out on long pages behind Traefik | Traefik read timeout (above) |
| Agents on other nodes cannot reach Kafka | `networkPolicies.kafkaClients` |
| Packet capture answers 403 | the agent namespace did not exist at install: `helm upgrade` again |

Support: https://axerasecurity.com/support
