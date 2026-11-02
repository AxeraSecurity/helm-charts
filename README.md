# Axera Helm Charts

Helm charts for [Axera](https://axerasecurity.com): Kubernetes microsegmentation, network
visibility and network detection & response (NDR). They run on OpenShift, k3s, RKE2 / Rancher,
Anthos (GKE Enterprise) and vanilla Kubernetes 1.25 or newer, on amd64 nodes.

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts
helm repo update
helm search repo axera
```

## Charts

| Chart | Version | Axera | What it installs | Namespace |
|---|---|---|---|---|
| [`axera`](charts/axera) | 3.0.0 | 17.2.0 | The **platform**: web console, API, analysis engine, policy watcher and, optionally, its own PostgreSQL and Kafka | any except `axera` (the examples use `axera-central`) |
| [`axera-force`](charts/axera-force) | 2.0.0 | 17.2.0 | The **cluster agent**, one DaemonSet: network flows, process activity and packet capture for one cluster, sent to the platform through Kafka | must be `axera` |
| `axera` (legacy, OpenShift only) | 1.4.0 | 8.3.0 | The earlier platform chart for OpenShift, kept in this repository | `axera` |

`helm install` or `helm upgrade` of `axera/axera` without `--version` now takes 3.0.0. To stay on
the legacy line, pass `--version 1.4.0`. Chart 3.0.0 does not install into namespace `axera`, the
1.x default; to move a 1.x install, see
[From 1.x in namespace `axera`](charts/axera/README.md#from-1x-in-namespace-axera).

On OpenShift, the Axera Operator from OperatorHub is the recommended way to install. The `axera`
chart keeps the Red Hat Helm chart certification annotations for Helm installs on OpenShift.

## Profiles and examples

Each chart ships one values file per distribution in `profiles/` and worked examples in
`examples/`. `-f` cannot read a file inside a chart in a remote repository, so extract the charts
first:

```bash
helm pull axera/axera --untar         # ./axera/profiles, ./axera/examples
helm pull axera/axera-force --untar   # ./axera-force/profiles, ./axera-force/examples
```

Then pass the files by path, for example `-f axera/profiles/values-k3s.yaml`. Fill a copy of a
profile: the install is refused while a `<<< FILL ... >>>` value is left. Keep the same `-f` files
for every `helm upgrade`. To pin a release, pass the same `--version` to `helm pull` and to
`helm install`. `helm show values axera/<chart>` prints only the chart's `values.yaml`.

Both charts take `global.distribution`: `auto` (the default), `openshift`, `k3s`, `rke2`,
`anthos` or `vanilla`. `auto` detects the distribution during `helm install` and `helm upgrade`.
`helm template`, Argo CD and Flux cannot see the cluster, so set the value there (the profiles do).

## Install shapes

| Shape | Charts | Kafka and PostgreSQL |
|---|---|---|
| [Full](#full-platform-and-agent-on-one-cluster) | `axera` in `axera-central` and `axera-force` in `axera`, on one cluster | in-cluster (lab, proof of concept) |
| [Central + remote agents](#central-platform-and-remote-agents) | `axera` on one cluster, `axera-force` on every monitored cluster | yours (external) |
| [Agent only](#agent-only-connect-a-cluster-to-an-existing-platform) | `axera-force`, reporting to a platform that already runs (Helm or operator install) | the platform's external Kafka |

Every shape creates its namespaces first, with Pod Security labels. The platform's pods pass
`baseline`. The agent needs `privileged`: it uses the host network, the host PID namespace and host
paths. On OpenShift the charts create SecurityContextConstraints instead.

```bash
# platform (Full and Central shapes)
kubectl create namespace axera-central
kubectl label namespace axera-central pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/audit=baseline pod-security.kubernetes.io/warn=baseline
# Anthos only: keep the platform namespace out of the mesh
# kubectl label namespace axera-central istio-injection=disabled
# agent (every cluster that runs axera-force)
kubectl create namespace axera
kubectl label namespace axera pod-security.kubernetes.io/enforce=privileged \
  pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
```

Do not add `--create-namespace` to the install commands below.

### Full: platform and agent on one cluster

On k3s, after creating both namespaces:

```bash
cp axera/examples/values-full-k3s.yaml my-full.yaml
# in my-full.yaml set expose.frontend.host, kafka.clusters and networkPolicies.kafkaClients.cidrs
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

`clusterName` must match an entry in the platform's `kafka.clusters` (`k3s-lab` in the example):
the platform creates and consumes the topics of the clusters listed there, and its Kafka creates no
topic on its own. That Kafka is single-node and plaintext, and only agents on the same cluster can
reach it. The platform owns the integration identity here, so the agent chart does not create one.
Register the cluster under **Settings > Integrations > Connections > Kubernetes Clusters > Manage Clusters >
Add Cluster**, with API URL `https://kubernetes.default.svc` and this token:

```bash
kubectl -n axera-central get secret axera-sa-token -o jsonpath='{.data.token}' | base64 -d; echo
```

For other distributions and the details, see
[(a) Full, one cluster](charts/axera/README.md#a-full-one-cluster).

### Central platform and remote agents

Install the platform with your PostgreSQL and Kafka. Layer the external-data profile and a copy of
the central example over your distribution's profile:

```bash
cp axera/examples/values-central-external.yaml my-central.yaml
helm upgrade --install axera axera/axera -n axera-central \
  -f axera/profiles/values-<distribution>.yaml -f axera/profiles/values-external-data.yaml \
  -f my-central.yaml
```

Connect each monitored cluster as in [Agent only](#agent-only-connect-a-cluster-to-an-existing-platform),
adding its name to `kafka.clusters` in `my-central.yaml`. The Secrets the example expects, the audit
stream from remote clusters and the full order of steps are in
[(b) Central platform, remote agents](charts/axera/README.md#b-central-platform-remote-agents).

### Agent only: connect a cluster to an existing platform

**1. Kafka topics and ACLs.** The agent writes to these topics but never creates them, and records
sent to a missing topic are dropped. Have them created first, each with `retention.ms=7200000`:

| Topic | Partitions | When |
|---|---|---|
| `<clusterName>` | 3 | always (east-west flows) |
| `<clusterName>-process` | 1 | always (process events) |
| `external-flows` | 1 | always; shared by every cluster, so it usually exists |
| `<clusterName>-dns` | 1 | with `flow.dnsVisibility: true` |

The agent's Kafka user needs a SCRAM-SHA-512 (or PLAIN) credential (the chart refuses SCRAM-SHA-256;
set `kafka.saslMechanism: Plain` for PLAIN) and Write and Describe on its topics. The platform's Kafka user needs Read, Describe and DescribeConfigs on
them, and Read on consumer groups `axera-radar` (flows), `axera-process` (process events) and
`axera-dns` (DNS).

```bash
B=kafka.example.com:9093; C=my-k3s   # admin.properties: your admin client's SASL/TLS settings
kafka-topics.sh --bootstrap-server $B --command-config admin.properties --create --topic $C --partitions 3 --config retention.ms=7200000
kafka-topics.sh --bootstrap-server $B --command-config admin.properties --create --topic $C-process --partitions 1 --config retention.ms=7200000
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<agent user> --operation Write --operation Describe \
  --topic $C --topic $C-process --topic external-flows
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> --operation Read --operation Describe --operation DescribeConfigs \
  --topic $C --topic $C-process --topic external-flows
kafka-acls.sh --bootstrap-server $B --command-config admin.properties --add \
  --allow-principal User:<platform user> --operation Read \
  --group axera-radar --group axera-process --group axera-dns
```

**2. Tell the platform to consume them.** Add `<clusterName>` to `kafka.clusters` in the platform
chart's values, or to `spec.kafka.clusters` in the Axera custom resource of an operator-managed
platform. With an external Kafka the platform only checks the topics:
**Settings > Integrations > Kafka Topics** in the console lists any that is missing.

**3. Create the namespace and the Kafka Secrets.** Create namespace `axera` with the `privileged`
labels shown above. The Secret names and keys are fixed: `kafka-ca` with key `ca.crt` (the broker's
CA in PEM form), and `kafka-sasl` with keys `username` and `password`.

```bash
kubectl -n axera create secret generic kafka-ca --from-file=ca.crt=./kafka-ca.crt
read -rs KAFKA_PW    # type the SASL password; it is not echoed
kubectl -n axera create secret generic kafka-sasl \
  --from-literal=username=<kafka user> --from-literal=password="$KAFKA_PW"
unset KAFKA_PW
```

Leave out `kafka-ca` and set `kafka.systemTrustStore: true` if the broker certificate chains to a
public CA. The agent reads both Secrets only when it starts. After rotating one, run
`kubectl -n axera rollout restart daemonset/axera-agent`.

**4. Install the agent.** The k3s example uses SASL_SSL with SCRAM-SHA-512. In a copy, set
`clusterName`, `podCIDR` and `serviceCIDR` (k3s defaults: 10.42.0.0/16 and 10.43.0.0/16),
`localNetworkCIDR` (your corporate range) and `kafka.bootstrapServers`:

```bash
cp axera-force/examples/values-k3s-external-kafka.yaml my-agent.yaml
helm install axera-force axera/axera-force -n axera -f my-agent.yaml
kubectl -n axera rollout status daemonset/axera-agent
```

On another distribution, pass `-f axera-force/profiles/values-<distribution>.yaml` and a values
file of your own with the same keys, leaving `global.distribution` to the profile. Anthos and
vanilla Kubernetes always need `podCIDR`.

**5. Register the cluster** under **Settings > Integrations > Connections > Kubernetes Clusters > Manage
Clusters > Add Cluster**:

- **Cluster Name**: exactly `clusterName`.
- **API URL**: the cluster's direct API server, reachable from the platform's pods. On k3s that is
  `https://<server node IP or VIP>:6443`, never the `127.0.0.1` in your kubeconfig. Add the
  address to the server's `--tls-san` if the certificate does not list it.
- **Token**: read it yourself and paste it into the console:
  `kubectl -n axera get secret axera-sa-token -o jsonpath='{.data.token}' | base64 -d; echo`

The agent runs on amd64 nodes only, on the host network, so every node must reach every Kafka
broker, and the brokers see node IPs. The nodes need a kernel of 5.8 or later with BTF, and free
host ports 2055 and 28080 (plus 28081-28084 for metrics). Block 2055/TCP from other hosts. See the
[agent README](charts/axera-force/README.md#prerequisites) for these prerequisites and one profile
per distribution.

## Offline / air-gapped

```bash
helm pull axera/axera --version 3.0.0
helm pull axera/axera-force --version 2.0.0
helm show chart axera/axera         # the artifacthub.io/images annotation lists every image
helm show chart axera/axera-force
```

Every image is pinned by digest. The `artifacthub.io/images` annotation in each chart's
`Chart.yaml` lists them. Mirror them with their digests (for example with `skopeo copy --all`), then:

- **axera**: set `global.imageRegistry` to your mirror. The Red Hat images need
  `images.postgres.rhel.registry` and `images.postgresBackup.rhel.registry`. The helm test image
  needs `tests.image`.
- **axera-force**: set the full references under `images.*` and, for a private registry,
  `imagePullSecrets`.

## Support

Documentation and support: <https://axerasecurity.com/support>
