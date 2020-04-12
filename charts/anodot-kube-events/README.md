# Anodot Kube Events



# Installation
```bash
helm repo add anodot https://anodot.github.io/helm-charts
```

## Simple setup
```shell script
helm upgrade -i anodot-kube-events --namespace=monitoring anodot/anodot-kube-events
```

## Advanced setup
```shell script
helm fetch anodot/anodot-kube-events --untar

```

Navigate to `anodot-kube-events` folder and edit `values.yaml` with required values.
Run next command to install chart
```shell script
helm upgrade -i anodot-kube-events . --namespace=monitoring
```

## Next
set `K8S_RELABEL_SERVICE_URL` under Values.configuration.env in anodot-remote-write values.yaml re deploy the remote-write

## RBAC
`anodot-kube-events` application requires access to next resources to assign ordinal labels. RBAC configuration applied by default.
To tun off RBAC configuration, use `--set rbac.enabled=false`

```yaml
    resources:
      - pods
      - replicasets
      - deployments
      - daemonsets
    verbs: ["get", "list", "watch"]
```