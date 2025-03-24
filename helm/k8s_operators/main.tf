resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  namespace  = "external-secrets"
  chart      = "external-secrets"
  repository = "https://charts.external-secrets.io"
  version    = "0.9.13" # Check for latest version

  create_namespace = true

  values = [<<EOF
serviceAccount:
  create: true
  name: "external-secrets-sa"
EOF
  ]
}
