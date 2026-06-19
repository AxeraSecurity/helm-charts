# Axera Helm Charts

Public Helm chart repository for [Axera](https://axerasecurity.com) — Kubernetes
**microsegmentation** and **network detection & response (NDR)** for OpenShift.

## Usage

```bash
helm repo add axera https://axerasecurity.github.io/helm-charts
helm repo update
helm install axera axera/axera -n axera --create-namespace
```

See the [chart README](charts/axera/README.md) for prerequisites, deployment
modes (one-box vs external Postgres/Kafka), configuration, and upgrade/uninstall.

## Charts

| Chart | Description |
|-------|-------------|
| [`axera`](charts/axera) | Axera microsegmentation & NDR platform for OpenShift |

## Red Hat certification

This chart targets the Red Hat OpenShift **Helm Chart certification** program and
is distributed via this external repository (provider-delivered). The
chart-verifier report is submitted to
[openshift-helm-charts/charts](https://github.com/openshift-helm-charts/charts).

## Support

Documentation and support: <https://axerasecurity.com/support>
