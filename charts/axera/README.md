# Axera — Microsegmentation & NDR for OpenShift

[Axera](https://axerasecurity.com) is a Kubernetes **microsegmentation** and
**network detection & response (NDR)** platform. It maps every east-west and
egress flow, turns observed traffic into least-privilege `NetworkPolicy`, and
triages incidents with on-prem AI. Axera runs entirely in-cluster, is
CNI-agnostic, and is strictly additive — it observes first and enforces nothing
until you choose to.

## Prerequisites

- Red Hat OpenShift **4.12+** (Kubernetes 1.25+)
- Helm **3.8+** and the `oc` CLI
- A default `StorageClass` (or set `global.storageClass`) for the internal
  Postgres / Kafka / Ollama PVCs
- Cluster-admin (or equivalent) to create the SCC + RBAC the chart ships
  (`global.createSCC`), or have an admin pre-create them
- Access to the Axera container images (set `imagePullSecret` if private)

## Install

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts
helm repo update
helm install axera axera/axera -n axera --create-namespace
```

After install, follow the printed notes to open the console Route and retrieve
the auto-generated admin password.

## Deployment modes

| Mode | `postgres.external` | `kafka.external` | Use case |
|---|---|---|---|
| **One-box** (default) | `false` | `false` | Dev / POC / demo — everything in-cluster |
| **Production** | `true` | `true` | Customer-managed Postgres + Kafka |
| **Hybrid** | mix | mix | Phased migration |

For production, copy [`values-production.yaml`](values-production.yaml), fill in
the external endpoints/credentials, and:

```bash
helm install axera axera/axera -n axera --create-namespace -f values-production.yaml
```

## Secrets

All application secrets (`accessTokenSecret`, `encryptionKey`/`encryptionIV`,
`adminPassword`, the pod-to-pod `internalToken`, and the internal Postgres
password) are **auto-generated on first install when left empty** and **re-read
from the cluster Secret on every upgrade**, so they stay stable. The chart ships
**no real secrets**. Pin any of them explicitly under `app.*` / `postgres.password`
if you prefer to manage them yourself.

## Key configuration

| Value | Default | Description |
|---|---|---|
| `global.namespace` | `axera` | Must match `--namespace`. |
| `global.clusterDomain` | `""` | Route hostname suffix; empty → OpenShift auto-assigns. |
| `global.storageClass` | `""` | PVC StorageClass; empty → cluster default. |
| `global.imageRegistry` | `quay.io/axera` | Image registry prefix. |
| `global.createSCC` | `true` | Create the `axera-scc` SCC + RBAC. |
| `postgres.external` / `kafka.external` | `false` | Internal vs external dependencies. |
| `ai.enabled` / `ai.external` | `true` / `false` | On-prem AI; in-cluster Ollama vs external endpoint. |
| `networkPolicies.enabled` | `true` | Namespace-scoped defensive NetworkPolicies. |

See [`values.yaml`](values.yaml) for the full, documented set, validated by
[`values.schema.json`](values.schema.json).

## Verify

```bash
oc get pods -n axera
oc get route frontend -n axera
helm test axera -n axera
```

## Upgrade

```bash
helm upgrade axera axera/axera -n axera -f your-values.yaml
```

The API runs single-replica with a `Recreate` strategy (it holds an RWO
DataProtection key-ring PVC), so a brief gap during upgrades is expected.

## Uninstall

```bash
helm uninstall axera -n axera
# Internal Postgres/Kafka PVCs persist by design — delete them to free storage:
oc delete pvc -l app.kubernetes.io/instance=axera -n axera
```

## Security & support

- SELinux runs **enforcing**; no privileged containers, host networking, or host
  paths. The bundled `axera-scc` grants only what the workloads need.
- Flow/process telemetry is collected by separate upstream eBPF agents
  (NetObserv eBPF agent, Cilium Tetragon) that you deploy on monitored clusters;
  this chart consumes their events via Kafka and ships no kernel components.

Docs and support: <https://axerasecurity.com/support>
