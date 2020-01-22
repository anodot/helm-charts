# Anodot Pod Relabel

This application is used to assign pods which are managed by deployments/replicasets/daemonsets 
with unique sequenced labels (`anodot.com/podName=${deployment-name}-${ordinal}`), where ordinal is generated based on total number of pods managed by given object.

Example:
```bash
kubectl get pods

NAME                                          READY   STATUS    RESTARTS   AGE
    cloudwatch-exporter-945b6685d-hxfcz       1/1     Running   0          124d
    cloudwatch-exporter-945b6685d-kxju5       1/1     Running   0          100d
```
2.
```bash
kubectl describe pods cloudwatch-exporter-945b6685d-hxfcz
Name:           cloudwatch-exporter-945b6685d-hxfcz
Namespace:      monitoring
Labels:         anodot.com/podName=cloudwatch-exporter-0


kubectl describe pods cloudwatch-exporter-945b6685d-kxju5
Name:           cloudwatch-exporter-945b6685d-kxju5
Namespace:      monitoring
Labels:         anodot.com/podName=cloudwatch-exporter-1
```

# Installation
```bash
helm repo add anodot https://anodot.github.io/helm-charts
```

## Simple setup
```shell script
helm upgrade -i anodot-pod-relabel --namespace=monitoring anodot/anodot-pod-relabel
```

## Advanced setup
```shell script
helm fetch anodot/anodot-pod-relabel --untar

```

Navigate to `anodot-pod-relabel` folder and edit `values.yaml` with required values.
Run next command to install chart
```shell script
helm upgrade -i anodot-pod-relabel . --namespace=monitoring
```

## Next
set `K8S_RELABEL_SERVICE_URL` under Values.configuration.env in anodot-remote-write values.yaml re deploy the remote-write

## RBAC
`anodot-pod-relabel` application requires access to next resources to assign ordinal labels. RBAC configuration applied by default.
To tun off RBAC configuration, use `--set rbac.enabled=false`

```yaml
    resources:
      - pods
      - replicasets
      - deployments
      - daemonsets
    verbs: ["get", "list", "watch", "patch"]
```