# Kubernetes Metrics Collector Installation Guide

## Prerequisities:

- Helm 3
- `kube-prometheus-stack` installed. See the installation steps below.


## Installation:

1. Add Anodot repository by running next command:

```bash
helm repo add anodot https://anodot.github.io/helm-charts
```

2. Add Metrics collector repo:

```bash
helm repo add anodot-cost https://pileus-cloud.github.io/charts
```

3. Create a values file and put relevant config

_values.yaml_

```yaml
# Default values for k8s-metrics-collector.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

image:
  tag: "0.2.20"

# workload: Deployment or CronJob
workload: Deployment

environment:
  MONITORING: 'anodot'
  LOG_TO_CLOUD_WATCH: 'true'

  # Put your values here
  PROMETHEUS_URL: 'http://prometheus-kube-prometheus-prometheus:9090'
  CLUSTER_NAME: 'your-cluster-name'
  ACCOUNT_ID: 'your-account-id'
  LINKED_ACCOUNT_ID: 'your-linked-account-id'
  CLOUD_PROVIDER: 'your-cloud-provider: aws, azure'
  
  # Provided by anodot
  CUSTOMER_NAME: 'customer-name'
  AWS_REGION: 'bucket-region'
  S3_BUCKET: 's3-bucket'
  AWS_ACCESS_KEY_ID: 'your-access-key-id-for-the-bucket'
  AWS_SECRET_ACCESS_KEY: 'your-secret-access-key-for-the-bucket'
  MONITORING_TOKEN: 'anodot-monitoring-token'

podAnnotations: {}

podSecurityContext: {}
  # fsGroup: 2000

securityContext: {}
  # capabilities:
  #   drop:
  #   - ALL
  # readOnlyRootFilesystem: true
  # runAsNonRoot: true
  # runAsUser: 1000

resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
  #   memory: 128Mi

nodeSelector: {}

tolerations: []

affinity: {}
```

4. Install the chart

```bash
helm install k8s-metrics-collector anodot-cost/k8s-metrics-collector -f values.yaml
```

5. Verify that the pod is up and running. 
