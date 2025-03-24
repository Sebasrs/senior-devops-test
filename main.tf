# We modularize everything so we actually split every piece of code
# Networking
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block  = var.vpc_cidr_block
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

# EKS
module "iam" {
  source = "./modules/iam"

  app_name    = var.app_name
  environment = var.environment
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.app_name}-eks-${var.environment}"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnet_ids
  control_plane_subnet_ids = module.vpc.private_subnet_ids

  # Implement Karpenter or AWS Auto Mode
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.large", "m6g.large", "c6g.large"]
    capacity_type  = "SPOT"
    iam_role_arn   = module.iam.role_id
  }

  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.large", "m6g.large", "c6g.large"]

      min_size      = 2
      max_size      = 10
      desired_size  = 2
      capacity_type = "SPOT"
      iam_role_arn  = module.iam.role_id
    }
  }
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = <<EOF
- userarn: arn:aws:iam::${var.AWS_ACCOUNT_NUMBER}:role/${var.AWS_GITHUB_ROLE_NAME}
  username: <username>
  groups:
    - system:masters
EOF
  }
}

module "k8s_operators" {
  source = "./helm/k8s_operators"
}

module "datadog" {
  source = "./helm/datadog"

  datadog_api_key = var.datadog_api_key
}

# Database
module "rds" {
  source = "./modules/rds-psql"

  vpc_cidr_block = var.vpc_cidr_block
  subnet_ids     = module.vpc.private_subnet_ids
}

# ECR to push the app
resource "aws_ecr_repository" "interview-go-app-ecr" {
  name                 = "interview-go-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}
