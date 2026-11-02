# axera-force

The Axera cluster agent for one Kubernetes cluster. It connects the cluster to a central Axera
platform: network flows and process events go to the platform's Kafka, and the platform talks to
the cluster's API with an integration identity this chart creates.

The chart installs, in namespace `axera`:

| Object | What it is |
|---|---|
| DaemonSet `axera-agent` (label `app=axera-agent`) | One pod per node: the eBPF flow agent, the flow pipeline, the process sensor, the shipper and an idle packet-capture sidecar. |
| Three ConfigMaps | The flow pipeline, process sensor and shipper configuration. |
| TracingPolicy `axera-force-egress-axera` + CRDs in `crds/` | The observe-only `tcp_connect` policy of the process sensor (CRDs v1.7.1). |
| ServiceAccount `axera-integration-sa`, Secret `axera-sa-token`, ClusterRoles `axera-integration-*-axera` | The identity you register in Axera (`integration.create`). The ServiceAccount and the token Secret are kept on `helm uninstall`; the ClusterRoles and bindings are removed. |
| Role `axera-capture-exec-agent` | Lets the registered identity exec into the agent pods, for packet capture in the `pcap-capture` sidecar. RBAC cannot narrow exec to one container, and the process sensor container runs as root with `SYS_ADMIN` in the host PID namespace, so **the registered token is equivalent to root on every node** (see [Security](#security)). |
| DaemonSet `axera-audit-forwarder` (opt-in) | Forwards selected Kubernetes API audit events to the central platform. |
| SecurityContextConstraints `axera-ebpf-axera` | OpenShift only. |

Container names are kept for compatibility with the Axera platform: `ebpf-agent` (flow agent),
`flowlogs-pipeline` (flow pipeline), `tetragon` (process sensor), `shipper`, `pcap-capture`.

## Supported distributions

`global.distribution` selects the defaults. `auto` (the default) detects the distribution during
`helm install` / `helm upgrade`; renders that cannot see the cluster (`helm template`, Argo CD)
silently fall back to `vanilla`: they show no release notes, so nothing warns.
**Always set `global.distribution` (and `podCIDR`) for offline renders.**

| Setting | `openshift` | `k3s` / `rke2` | `anthos` | `vanilla` |
|---|---|---|---|---|
| OpenShift SCC (`createSCC: auto`) | yes | no | no | no |
| `podCIDR` default | read from the Network object (live install); **required** offline | 10.42.0.0/16, refused when a node's pod range lies outside it (live install); **required** offline | **required** | **required** |
| `serviceCIDR` default | read from the Network object (live install), else 172.30.0.0/16 | 10.43.0.0/16 | none (set it) | none (set it) |
| `flow.tcAttachMode` default | `any` | `any` | `tcx` (tc / any refused) | `any` |
| CRI socket hint | none | /run/k3s/containerd/containerd.sock | /run/containerd/containerd.sock | none |
| AppArmor | n/a (SELinux) | unconfined for the eBPF containers and the capture sidecar (`appArmorProfile` on 1.30+, annotations before) | same | same |
| Pod network namespace access | off on OVN-Kubernetes / OpenShiftSDN | on | on | on |
| North-south ingress lane (`flow.ingress`) | allowed | refused | refused | refused |
| Audit forwarder | `/var/log/kube-apiserver` | `auditForwarder.logDir` (profile sets it) | refused | `auditForwarder.logDir` required |

`profiles/values-<distribution>.yaml` holds only what differs for each distribution.

## Prerequisites

- Kubernetes 1.25 or later; Linux **amd64** nodes (the shipper and capture images are amd64-only,
  and `requireAmd64: true` keeps the agent off other nodes). Kernel 5.8 or later with BTF
  (`/sys/kernel/btf/vmlinux`).
- Helm 3.12 or later.
- A central Axera platform, and its Kafka reachable from **every node** (the agent uses the host network,
  so the brokers see node IPs).
- The central platform must reach this cluster's API server (port 6443 on k3s / RKE2 / kubeadm).
- Free host ports on every node: 2055/TCP and 28080/TCP, and 28081-28084/TCP on the node IP with
  `metrics.enabled` (the default). **2055/TCP is the flow pipeline's plaintext, unauthenticated
  ingest**: only the agent on the same node uses it (127.0.0.1), but it listens on every node address,
  and NetworkPolicy does not cover host-network pods. Block it from other hosts in the node or network
  firewall (for example an nftables / iptables INPUT rule that accepts 2055/TCP only from 127.0.0.1),
  or anyone who reaches a node can inject flow records that Axera files as this cluster's traffic.
  28080 needs no remote access (the kubelet probes it on the node); open 28081-28084 only to your
  Prometheus scrapers.
- Namespace `axera` with Pod Security `privileged`. The chart refuses any other namespace (the Axera API
  finds the agent and the integration identity only there):

  ```bash
  kubectl create namespace axera
  kubectl label namespace axera \
    pod-security.kubernetes.io/enforce=privileged \
    pod-security.kubernetes.io/audit=privileged \
    pod-security.kubernetes.io/warn=privileged
  ```

  On Rancher-managed clusters with a restricted PSA template, add `axera` to the template's exemptions
  (or have a user with the `updatepsa` right apply the labels).
- Do not install this chart on a cluster where the Axera operator already runs an agent (`AxeraForce`):
  both would own DaemonSet `axera-agent`.

## Connect to an existing Axera platform (agent only)

### 1. Kafka topics and ACLs

The agent writes to these topics. **Create them before installing**: the flow pipeline never creates
a topic, and records to a missing one are dropped.

| Topic | Content | When |
|---|---|---|
| `<clusterName>` | east-west flows | always |
| `<clusterName>-process` | process events | always |
| `external-flows` | egress flows, shared by every cluster | always (usually exists already) |
| `<clusterName>-dns` | DNS records | `flow.dnsVisibility: true` |
| `ingress-flows` | north-south ingress (OpenShift only) | `flow.ingress.enabled: true` |
| `intercluster-flows` (`submariner.topic`) | cross-cluster flows | `submariner` set |

The platform's own defaults are 3 partitions for the flow topic and 1 for the others, 2 h retention.
Example with the Kafka CLI (`admin.properties` holds your admin client's SASL/TLS settings):

```bash
B=kafka.example.com:9093; C=my-k3s
kafka-topics.sh --bootstrap-server $B --command-config admin.properties --create --topic $C --partitions 3 --config retention.ms=7200000
kafka-topics.sh --bootstrap-server $B --command-config admin.properties --create --topic $C-process --partitions 1 --config retention.ms=7200000
```

ACLs: the agent's Kafka user needs **Write** and **Describe** on its topics. The platform's user needs
**Read**, **Describe** and **DescribeConfigs** on them (DescribeConfigs lets the platform check each
topic's retention), and **Read** on consumer groups `axera-radar` (flow, external-flows, ingress and
intercluster topics), `axera-process` (process topics) and `axera-dns` (DNS topics):

```bash
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<agent user> --operation Write --operation Describe \
  --topic $C --topic $C-process --topic external-flows
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> --operation Read --operation Describe --operation DescribeConfigs \
  --topic $C --topic $C-process --topic external-flows
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> --operation Read \
  --group axera-radar --group axera-process
```

With `flow.dnsVisibility` add `--topic $C-dns` to the two topic commands and `--group axera-dns` to
the group command; with `flow.ingress.enabled` add `--topic ingress-flows`, and with `submariner`
`--topic intercluster-flows` (or your `submariner.topic`), to the two topic commands.

The SASL mechanism must be **SCRAM-SHA-512** (or PLAIN): the flow pipeline cannot log in with
SCRAM-SHA-256, and the chart refuses it.

### 2. Tell the central platform to consume them

Add the cluster to the platform's Kafka topic configuration: `kafka.clusters: [<clusterName>]` in the
platform chart's values, or `spec.kafka.clusters` in the Axera custom resource of an operator-managed
platform (Axera derives `<c>`, `<c>-process` and `<c>-dns` and adds the shared topics), or the explicit
lists (`kafka.topics`, `kafka.processTopics` with `clusterName`, `kafka.dnsTopics`). With an external
broker the platform verifies the topics and lists any missing one, with the command that creates it,
under Settings > Integrations > Kafka Topics. In this convention mode the platform also consumes
`<clusterName>-dns` and the shared `ingress-flows` and `intercluster-flows` topics, so that page lists
each of them that does not exist. Create them (1 partition, 2 h retention), or ignore those entries
until you use DNS visibility, the OpenShift ingress lane or Submariner.

### 3. Create the Kafka Secrets

With `kafka.createSecret: false` (the default) you create the credentials yourself; the names and keys
are fixed:

```bash
kubectl -n axera create secret generic kafka-ca --from-file=ca.crt=./kafka-ca.crt
read -rs KAFKA_PW    # type the SASL password; it is not echoed
kubectl -n axera create secret generic kafka-sasl \
  --from-literal=username=<kafka user> --from-literal=password="$KAFKA_PW"
unset KAFKA_PW
```

`kafka-ca` is needed for `Ssl` / `SaslSsl` (skip it with `kafka.systemTrustStore: true` when the broker
certificate chains to a public CA), `kafka-sasl` for `SaslPlaintext` / `SaslSsl`. The agent reads them
only at start. **After rotating either Secret, restart the agent**:

```bash
kubectl -n axera rollout restart daemonset/axera-agent
```

`helm upgrade` rolls the pods by itself only when it can read the Secrets; `helm template` and GitOps
renders cannot, so add the restart to your rotation procedure there.

The flow pipeline uses only the **first** entry of `kafka.bootstrapServers` and discovers the other
brokers from its metadata; the shipper uses the whole list. Every node must reach every broker the
metadata advertises.

### 4. Install

See [Install per distribution](#install-per-distribution).

If the cluster was prepared with Axera's static integration manifest
(`axera-sa.yaml`, supplied with the Axera platform), `axera/axera-integration-sa` and `axera/axera-sa-token`
already exist and their token may already be registered in Axera. **Do not delete them** (that mints a
new token and breaks the registration); adopt them into the release before installing, and the chart
keeps the token:

```bash
kubectl -n axera label serviceaccount/axera-integration-sa secret/axera-sa-token \
  app.kubernetes.io/managed-by=Helm --overwrite
kubectl -n axera annotate serviceaccount/axera-integration-sa secret/axera-sa-token \
  meta.helm.sh/release-name=axera-force meta.helm.sh/release-namespace=axera --overwrite
```

The chart refuses to install over them otherwise, and prints these commands. The manifest's
unsuffixed ClusterRoles and Role `axera-capture-exec` can stay (harmless duplicates) or be deleted.
Alternatively keep the identity outside the chart with `integration.create: false`.

### 5. Register the cluster in Axera

In Axera: Settings > Integrations > Connections > Kubernetes Clusters > Manage Clusters > Add Cluster.

- **Cluster Name**: `clusterName` (exactly; Axera maps the flow topic to it).
- **Token**: read it yourself and paste it into the UI (never send it by e-mail or chat):

  ```bash
  kubectl -n axera get secret axera-sa-token -o jsonpath='{.data.token}' | base64 -d; echo
  ```

  The cluster CA, if your Axera version asks for it:
  `kubectl -n axera get secret axera-sa-token -o jsonpath='{.data.ca\.crt}' | base64 -d`
- **API URL**: the cluster's **direct** API server, reachable from the central platform's pods and
  passing WebSocket / streaming traffic (packet capture runs `exec` over it):
  - k3s: `https://<server node IP or VIP>:6443`. Not `https://127.0.0.1:6443` from your kubeconfig: from
    the platform that is its own node. Add a VIP or DNS name to the server certificate with
    `--tls-san` if it is not already there.
  - RKE2: `https://<server node IP or VIP>:6443`, or Rancher's Authorized Cluster Endpoint. Not the Rancher
    server URL: its proxy acts as a Rancher user and closes `exec` streams.
  - Anthos: the user cluster's control-plane VIP (the kubeconfig `server:`), not the Connect gateway.
  - OpenShift: `https://api.<cluster domain>:6443`.
  - kubeadm: the API server address or load balancer in your kubeconfig `server:`.

## Install per distribution

Add the repository once:

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts
helm repo update
```

Every install needs the namespace and the Kafka Secrets above, plus `clusterName` and
`kafka.bootstrapServers` (and `podCIDR` on Anthos, vanilla Kubernetes and every offline render). The profiles ship inside the chart; `helm pull axera/axera-force --untar`
gives you `axera-force/profiles/` and `axera-force/examples/`.

### k3s

```bash
helm install axera-force axera/axera-force -n axera \
  --set global.distribution=k3s \
  --set clusterName=my-k3s \
  --set kafka.bootstrapServers=kafka.example.com:9093
```

or `-f my-agent.yaml`, an edited copy of `axera-force/examples/values-k3s-external-kafka.yaml`
(a later `helm pull --untar` overwrites edits made inside the chart). With `podCIDR` empty a
live install takes the k3s default 10.42.0.0/16 and refuses to install when a node's pod range
(`kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}'`) lies outside it. Set `podCIDR` /
`serviceCIDR` if the cluster was started with other `--cluster-cidr` / `--service-cidr` values, and
always for offline renders (`helm template`, GitOps). The same holds for RKE2.

### RKE2 / Rancher

```bash
helm install axera-force axera/axera-force -n axera \
  -f axera-force/profiles/values-rke2.yaml \
  --set clusterName=my-rke2 --set kafka.bootstrapServers=kafka.example.com:9093
```

With the CIS profile, label (or exempt) namespace `axera` first. Rancher's Apps catalog works too:
add the repository under Apps > Repositories and set the same values.

### Anthos (GKE on VMware / bare metal)

```bash
helm install axera-force axera/axera-force -n axera \
  -f axera-force/profiles/values-anthos.yaml \
  --set clusterName=my-anthos --set kafka.bootstrapServers=kafka.example.com:9093 \
  --set podCIDR=192.168.0.0/16 --set serviceCIDR=10.96.0.0/20 \
  --set localNetworkCIDR=10.0.0.0/8
```

`podCIDR` is required (read it from the user cluster configuration). The chart default
`localNetworkCIDR` (192.168.0.0/16) equals Anthos' usual pod CIDR and is refused: set your corporate
range. `flow.tcAttachMode` defaults to `tcx` on Anthos (the profile sets it too) so the flow agent
never touches Dataplane V2's TC programs, and `tc` / `any` are refused there, offline renders included;
nodes whose kernel has no TCX (older than 6.6) then capture no flows. The audit forwarder is not
supported on Anthos.

### Vanilla Kubernetes (kubeadm)

```bash
helm install axera-force axera/axera-force -n axera \
  -f axera-force/profiles/values-vanilla.yaml \
  --set clusterName=my-cluster --set kafka.bootstrapServers=kafka.example.com:9093 \
  --set podCIDR=10.244.0.0/16 --set serviceCIDR=10.96.0.0/12
```

`podCIDR` is the kubeadm `--pod-network-cidr`. With Calico on 192.168.0.0/16, set `localNetworkCIDR` to
your corporate range. With an eBPF CNI that attaches TC programs, set `flow.tcAttachMode: tcx`.

### OpenShift

```bash
helm install axera-force axera/axera-force -n axera \
  -f axera-force/profiles/values-openshift.yaml \
  --set clusterName=my-ocp --set kafka.bootstrapServers=kafka.example.com:9093
```

The chart creates SecurityContextConstraints `axera-ebpf-axera`. A live install reads the pod and
Service networks from the Network object (`oc get network.config cluster -o yaml`); an offline render
(GitOps) must set `podCIDR` (and `serviceCIDR` when it is not 172.30.0.0/16).

"Apply from Axera" in Settings > Integrations > Ingress & Load Balancers needs an opt-in grant on the
IngressControllers: set `integration.ingressLoggingApply.enabled: true` (and list them in
`integration.ingressLoggingApply.ingressControllers`, default `[default]`). Without it Axera shows the
patch to copy and apply yourself.

## Main values

| Key | Default | Meaning |
|---|---|---|
| `global.distribution` | `auto` | `openshift`, `k3s`, `rke2`, `anthos`, `vanilla`; see the table above. |
| `clusterName` | `""` | **Required.** Registered cluster name and flow topic. |
| `podCIDR`, `serviceCIDR`, `extraPodCIDRs` | read or checked on a live install; required offline | In-cluster ranges (labelled ClusterSubnet). |
| `localNetworkCIDR`, `extraLocalNetworkCIDRs` | `192.168.0.0/16` | Corporate ranges (labelled LocalNetwork); must not lie inside an in-cluster range. |
| `kafka.bootstrapServers` | `""` | **Required.** `host:port` of the central Kafka. |
| `kafka.securityProtocol` / `saslMechanism` | `SaslSsl` / `ScramSha512` | `Plaintext`, `Ssl`, `SaslPlaintext`, `SaslSsl` / `ScramSha512`, `Plain`. |
| `kafka.createSecret` | `false` | `false`: you create `kafka-ca` and `kafka-sasl`. |
| `kafka.systemTrustStore` | `false` | Trust the broker through the images' public CA bundle (no `kafka-ca`). |
| `flow.tcAttachMode` | `""` (`tcx` on Anthos, `any` elsewhere) | `any`, `tcx`, `tc`. Use `tcx` with an eBPF CNI (see below). |
| `flow.dnsVisibility`, `flow.udp`, `flow.enablePktDrops` | `false`, `true`, `false` | Flow lanes. |
| `process.observe.*`, `process.execExport` | application namespaces, `false` | What the process sensor ships. |
| `images.*` | pinned by digest | `flowAgent`, `flowPipeline`, `processSensor`, `shipper`, `capture`, `auditForwarder`. |
| `imagePullSecrets` | `[]` | For a private mirror. |
| `requireAmd64` | `true` | Schedule on amd64 nodes only. |
| `capture.enabled`, `capture.integrationNamespaces` | `true`, `[]` | Packet capture and who may exec. |
| `integration.create`, `integration.leastPrivilege` | `true`, `false` | The integration identity and its optional grants (see [Security](#security)). |
| `integration.ingressLoggingApply.enabled` | `false` | OpenShift: let Axera patch the router access logging. |
| `updateStrategy` | `{}` | `type: OnDelete`, or `maxUnavailable` (integer, or a percentage such as `"10%"`). |
| `createSCC` | `auto` | OpenShift SCC. |
| `metrics.enabled` | `true` | Prometheus endpoints (PodMonitor when the Prometheus Operator is present). |
| `resources.*`, `resourceDefaults.*` | small requests | Per container: `flowAgent`, `flowPipeline`, `processSensor`, `btfCheck`, `shipper`, `capture`. |
| `auditForwarder.*` | disabled | See below. |

`values.yaml` documents every key; `values.schema.json` validates them.

**`flow.tcAttachMode`.** `tcx` (kernel 6.6+) attaches beside any other TC program. `tc`, and `any` on a
kernel without TCX, use the legacy clsact qdisc, which **replaces an existing clsact qdisc and removes
the TC programs a CNI attached there**. Flannel (k3s), Canal (RKE2 default), plain Calico,
OVN-Kubernetes and OpenShiftSDN attach none, so `any` is safe there. With an eBPF CNI (Anthos Dataplane
V2, Calico in eBPF mode and similar) use `tcx`. What the chart detects and refuses `tc` / `any` for:

- in every render, offline included: `global.distribution: anthos`, and an API server that serves
  `cilium.io/v2` (Argo CD passes the cluster's API versions to its renders);
- at `helm install` / `helm upgrade` only: DaemonSet `anetd` or `cilium` in `kube-system` (or `cilium`
  in namespace `cilium`), an OpenShift `networkType` of that eBPF CNI, and Calico's eBPF dataplane
  (Installation `default` with `linuxDataplane: BPF`, or FelixConfiguration `default` with
  `bpfEnabled: true`).

Nothing else is detected: with another eBPF CNI, or an offline render of one the list above does not
cover, set `flow.tcAttachMode: tcx` yourself.

## Security

What the registered integration token (Secret `axera-sa-token`, long-lived, stored in the central
platform's database) can do with the defaults:

- **Root on every node.** Role `axera-capture-exec-agent` lets it exec into any pod in namespace `axera`
  (RBAC cannot narrow exec to the capture sidecar), and the agent pod's process sensor container runs
  as root with `SYS_ADMIN` and `SYS_PTRACE` in the host PID namespace. `capture.enabled: false` removes
  the grant (and packet capture).
- **ClusterRole `axera-integration-extended`**: service-mesh routing writes, cluster-wide `pods/log`,
  update and delete of any Namespace.
- **ClusterRole `axera-integration-agent-deploy`**: lets Axera install another agent from its UI
  (DaemonSet, RBAC and SCC create), which is also root on a node. Not needed with this chart.

`integration.leastPrivilege: true` leaves out the last two (pod logs are then read only through Roles in
`integration.podLogsNamespaces`); together with `capture.enabled: false` it is the minimum. The agent's
own ServiceAccount (`axera-agent`) is read-only and has no exec grant. Keep 2055/TCP firewalled (see
Prerequisites). In the full shape the platform chart grants the same exec on its own (Role
`axera-capture-exec-<platform namespace>` in `axera`, see below), so `capture.enabled: false` here
does not remove it: also set `integration.namespacedRoles: never` on the platform.

## Full shape: the platform runs on this same cluster

The platform already created its own `axera-integration-sa` in its namespace and registers that one.
Do not create a second identity; grant capture to the platform's:

```yaml
integration:
  create: false
capture:
  integrationNamespaces: [<platform namespace>]
```

With the platform's in-cluster Kafka (`kafka.bootstrapServers: kafka.<platform namespace>.svc.cluster.local:9092`,
`kafka.securityProtocol: Plaintext`) skip the topic, ACL and Secret steps above: that broker has no
users or ACLs, and the platform creates the agent's topics there from its `kafka.clusters`, which
must include `clusterName`. The install notes treat a broker as the platform's own only with all of
these together: plaintext, a `kafka.<namespace>` address, `integration.create: false` and that
namespace in `capture.integrationNamespaces`. A plaintext broker of your own, even a Service called
`kafka`, is not the platform's: create its topics first, as above.

When namespace `axera` existed at the platform's install (or upgrade), the platform chart has already
rendered Role `axera-capture-exec-<platform namespace>` there with the same grant, so
`capture.integrationNamespaces` only duplicates it; it matters when the platform runs with
`integration.namespacedRoles: never`. Revoking capture on this shape needs both: `capture.enabled:
false` here and `integration.namespacedRoles: never` on the platform.

## Audit forwarder (optional)

`auditForwarder.enabled: true` runs a DaemonSet on the control-plane nodes that reads the API server's
`audit.log`, keeps only policy changes (NetworkPolicy, AdminNetworkPolicy, mesh security policies), RBAC
binding writes, `exec` / `attach` into pods, secret listing and anonymous access, and posts them to the
central platform:

```yaml
auditForwarder:
  enabled: true
  targetUri: https://<host that reaches the central api Service>/api/Internal/Audit
  logDir: /var/lib/rancher/k3s/server/logs     # k3s; RKE2: /var/lib/rancher/rke2/server/logs
  caCert: ""                                   # PEM of the central API's CA, if private
# internal token: --set-file auditForwarder.internalToken=./internal-token (keep it out of git)
```

`targetUri` must reach the central platform's `api` Service. **It is not the console host**: the
console answers 404 to `/api/Internal/*`, and the forwarder drops a batch answered 404, so the audit
lane would be silently empty.

- Central from the `axera` chart on OpenShift: set `routes.api.enabled: true` and `routes.api.host`
  there (a Route for that one path), then use `https://<routes.api.host>/api/Internal/Audit`.
- Operator-installed central: `https://api-axera-central.apps.<cluster domain>/api/Internal/Audit`.
- Central from the `axera` chart behind an Ingress or Istio: set `expose.auditIngest.enabled: true`
  there (one exact-path rule on the UI host, and the matching NetworkPolicy), then use
  `https://<expose.frontend.host>/api/Internal/Audit`.
- Any other central behind an Ingress: expose only the path `/api/Internal/Audit` to Service `api`,
  port 8080, in the platform namespace, and let the ingress controller reach the `api` pods on 8080.
  A minimal Ingress:

  ```yaml
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: axera-audit-ingest
    namespace: <platform namespace>
  spec:
    rules:
      - host: <audit host>
        http:
          paths:
            - path: /api/Internal/Audit
              pathType: Exact
              backend:
                service: { name: api, port: { number: 8080 } }
    tls:
      - hosts: [<audit host>]
  ```

The release notes print how to read the HTTP answers the forwarder gets.

The API server must write `audit.log` into `logDir` on the control-plane nodes, with a policy that logs
the kept resources. Policy and binding writes need level **RequestResponse** (the bodies show what
changed); `exec`, `attach` and secrets need only Metadata (never log Secret bodies; the forwarder never
forwards them). Merge these rules into your policy, above its catch-all rule:

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
omitStages: ["RequestReceived"]
rules:
  - level: RequestResponse
    verbs: ["create", "update", "patch", "delete"]
    resources:
      - group: networking.k8s.io
        resources: ["networkpolicies"]
      - group: policy.networking.k8s.io
        resources: ["adminnetworkpolicies", "baselineadminnetworkpolicies"]
      - group: security.istio.io
        resources: ["authorizationpolicies", "peerauthentications", "requestauthentications"]
      - group: rbac.authorization.k8s.io
        resources: ["clusterrolebindings", "rolebindings"]
  - level: Metadata
    resources:
      - group: ""
        resources: ["pods/exec", "pods/attach", "secrets"]
      - group: rbac.authorization.k8s.io
        resources: ["clusterroles", "roles", "clusterrolebindings", "rolebindings"]
  - level: None
```

**k3s** does not audit by default. On every server node, save the policy as
`/var/lib/rancher/k3s/server/audit.yaml`, then:

```bash
sudo mkdir -p -m 700 /var/lib/rancher/k3s/server/logs
sudo tee -a /etc/rancher/k3s/config.yaml >/dev/null <<'EOF'
kube-apiserver-arg:
  - audit-log-path=/var/lib/rancher/k3s/server/logs/audit.log
  - audit-policy-file=/var/lib/rancher/k3s/server/audit.yaml
  - audit-log-maxage=7
  - audit-log-maxbackup=5
  - audit-log-maxsize=100
EOF
sudo systemctl restart k3s
```

(If `config.yaml` already has `kube-apiserver-arg`, add the lines to that list instead.)

**RKE2** writes `/var/lib/rancher/rke2/server/logs/audit.log` only with `profile: cis` or
`audit-policy-file` set, and its default policy logs nothing: set `audit-policy-file` in
`/etc/rancher/rke2/config.yaml` to a policy with the rules above and restart `rke2-server`.

**kubeadm**: set `--audit-policy-file` and `--audit-log-path=<dir>/audit.log` on the API server (mount
both into its static pod) and set `auditForwarder.logDir: <dir>`. The file must be named `audit.log`.

## Upgrade

Keep your settings in a values file and pass it on every upgrade:

```bash
helm upgrade axera-force axera/axera-force -n axera -f my-values.yaml
```

**Do not use `--reuse-values`**: it keeps the previous chart's defaults, including its image digests,
so the agent is not upgraded (or runs old images under new configuration). With Helm 3.14 or later,
`--reset-then-reuse-values` is the safe alternative.

Helm never upgrades or deletes `crds/`. When a chart release moves to a newer process sensor, apply its
CRDs first (Helm created them, so their fields belong to the `helm` field manager):

```bash
helm pull axera/axera-force --version <new version> --untar
kubectl apply --server-side --force-conflicts -f axera-force/crds/
```

Renders without cluster access (GitOps) must carry `global.distribution` and `podCIDR`, and
`--include-crds` for the CRDs.

### Upgrading from the 1.1.1 package

Chart 2.0.0 renamed or removed several keys of the 1.1.1 package (`global.platform` is now
`global.distribution`; the image keys, the per-container `resources` keys, `capture.image`,
`auditForwarder.image` and `podSecurityContext` changed), so the old values do not pass this chart's
schema. Do not carry them over: start a new values file from `profiles/values-<distribution>.yaml`
and `values.yaml` with your `clusterName`, `podCIDR`, `localNetworkCIDR`, Kafka and audit forwarder
settings (`helm get values axera-force -n axera -o yaml` shows the old ones), leave the images at the
chart's pinned defaults (or set the new `images.*` keys for a mirror), then upgrade with `-f`.

## Uninstall

```bash
helm uninstall axera-force -n axera
```

Kept on purpose: the CRDs (`tracingpolicies`, `tracingpoliciesnamespaced`, `podinfo` in `cilium.io`),
and ServiceAccount `axera-integration-sa` with Secret `axera-sa-token`. Your Secrets `kafka-ca` and
`kafka-sasl` stay too. On each node the process sensor's export directory (the `export-logs` hostPath
of DaemonSet `axera-agent`, under `/var/run`) keeps its last events until the node reboots or you
delete it. The integration ClusterRoles, their bindings and the capture Role are removed, so the
registered token has no permissions until you reinstall. A reinstall with the same release name
(`axera-force`) in namespace `axera` adopts the kept objects and the token stays registered in Axera. To reinstall under another release name, first run
`kubectl -n axera annotate serviceaccount/axera-integration-sa secret/axera-sa-token
meta.helm.sh/release-name=<new name> --overwrite` (the chart refuses otherwise and prints the commands).
To remove everything, after removing the cluster from Axera:

```bash
kubectl -n axera delete secret axera-sa-token kafka-ca kafka-sasl --ignore-not-found
kubectl -n axera delete serviceaccount axera-integration-sa --ignore-not-found
kubectl delete namespace axera
# only if nothing else on the cluster uses these CRDs:
kubectl delete crd tracingpolicies.cilium.io tracingpoliciesnamespaced.cilium.io podinfo.cilium.io
```

## Troubleshooting

The agent pods stay `Running` and ready when the broker refuses them (TLS, login, ACL, missing topic):
those errors show only in the logs of the flow pipeline container (flows) and the `shipper` container
(process events); see [Container names](#axera-force).

| Symptom | Cause and fix |
|---|---|
| Pods stay `Init:0/1` (`ContainerCreating`), events `MountVolume.SetUp failed ... secret "kafka-ca" not found` | `kafka-ca` or `kafka-sasl` is missing: `kubectl -n axera describe pod -l app=axera-agent`. The pods start by themselves once the Secrets exist. |
| `rollout status` succeeds but no agent pod exists (`DESIRED 0`) | No node matches the agent's node selector. With `requireAmd64: true` the nodes must be amd64: `kubectl get nodes -L kubernetes.io/arch`. |
| `shipper` in `CreateContainerConfigError` (`couldn't find key username in Secret axera/kafka-sasl`), the flow pipeline container crash-looping (`open /etc/kafka-sasl/username: no such file or directory`) | `kafka-sasl` lacks the key `username` (or `password`). A user Secret copied from a Kafka operator often holds only `password`: create `kafka-sasl` with both keys. |
| Flow pipeline logs `x509: certificate signed by unknown authority`, shipper logs `SSL handshake failed ... certificate verify failed` | `kafka-ca` does not hold the CA that signed the broker certificate. Put the issuing CA (with an intermediate CA, the chain up to the root) in `ca.crt`, or set `kafka.systemTrustStore: true` when a public CA signed it. `x509: certificate is valid for ..., not ...`: `kafka.bootstrapServers` and the brokers' advertised names must be names in the broker certificate. |
| `violates PodSecurity` | Label namespace `axera` privileged (Prerequisites). |
| No agent pod on some nodes | `requireAmd64` keeps it off non-amd64 nodes; check `nodeSelector` / `tolerations`. |
| `exec format error`, `no match for platform in manifest` | An amd64-only image on an arm64 node: keep `requireAmd64: true`. |
| `ebpf-agent` fails with `/var/run/netns ... is not a shared or slave mount` | The node's `/var/run` is not a shared mount (nodes running inside containers, such as k3d). Set `flow.podNetnsAttach: false`. |
| Flow pipeline logs `Unknown Topic Or Partition`, shipper logs `Unknown partition` / `Unknown topic` | Create the topics. The agent resumes by itself once they exist. |
| Shipper logs `SASL authentication error: Authentication failed ... invalid credentials` | Wrong user or password, a user without a SCRAM-SHA-512 credential, or a trailing newline in `kafka-sasl`. A trailing newline fails only the shipper (the flow pipeline trims it), so flows arrive and process events do not. Re-create the Secret with `--from-literal`. |
| No flows on a node | `kubectl -n axera logs ds/axera-agent -c ebpf-agent` (flow agent) and `-c flowlogs-pipeline` (flow pipeline). With `tcAttachMode: tcx` the node needs kernel 6.6+. |
| No process events | `kubectl -n axera logs ds/axera-agent -c tetragon` (process sensor) and `-c shipper`. |
| Packet capture answers 403 | The registered identity has no exec grant: `capture.integrationNamespaces` (full shape) or `integration.create`. |
| Install fails with a namespace message | The chart installs only into `axera`. |
| `helm template` asks for `podCIDR` or renders for vanilla | Set `global.distribution` and `podCIDR` (offline renders cannot read the cluster). |
| Install refuses: a node's pod range lies outside the pod CIDR | The k3s / RKE2 cluster was started with another `--cluster-cidr`: set `podCIDR` (and `serviceCIDR`). |
| Install refuses: `axera-integration-sa` / `axera-sa-token` belong to no release | Adopt them with the printed commands (see [Install](#4-install)); never delete them. |
| `btf-check` logs `ERROR: /sys/kernel/btf/vmlinux not found` | The node's kernel has no BTF (`CONFIG_DEBUG_INFO_BTF=y`, kernel 5.8+): the flow agent and the process sensor cannot start there. |
| Render fails: `images.flowPipeline ... is the legacy Axera flow pipeline build` | That mirrored image cannot read this chart's configuration: mirror the chart's default `images.flowPipeline`. |
| Audit forwarder answers HTTP 404 (the series whose name ends in `http_client_responses_total`, with `status="404"`, on its metrics port 9598) | `targetUri` is the console host: point it at the api Route / Ingress for `/api/Internal/Audit` (see [Audit forwarder](#audit-forwarder-optional)). |
| Audit forwarder answers HTTP 401 / 403 | Wrong `auditForwarder.internalToken`. |

## Licensing

Axera counts a cluster's licensed nodes by the label `node-role.kubernetes.io/worker`. OpenShift sets
it; k3s, RKE2, Anthos and kubeadm nodes do not carry it by default. Label the nodes that run your
workloads:

```bash
kubectl label node <node> node-role.kubernetes.io/worker=
```
