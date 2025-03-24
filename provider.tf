provider "aws" {
  region = "us-east-1"

  # Default tagging for all resources so we don't have to tag each resource if no additional tags needed
  default_tags {
    tags = var.tags
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  }
}
