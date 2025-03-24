resource "helm_release" "datadog" {
  name       = "datadog"
  namespace  = "datadog"
  chart      = "datadog"
  repository = "https://helm.datadoghq.com"
  version    = "3.110.3"

  create_namespace = true

  values = [<<EOF
datadog:
  apiKey: "${var.datadog_api_key}"
  site: "datadoghq.com"

  logs:
    enabled: true

  apm:
    enabled: true

  processAgent:
    enabled: true

  kubeStateMetricsEnabled: true

  clusterAgent:
    enabled: true
EOF
  ]
}
