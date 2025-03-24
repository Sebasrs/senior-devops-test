# Senior DevOps Challenge
Since this is just a test we won't deploy it

Resources created
- VPC
- IAM Roles
- EKS Cluster
    + Datadog Agent
    + External Secrets Operator
    + RBAC Config
- RDS Postgres Engine

# Deployment
Most configuration are already taken care of, we assume you have the following pieces:
- AWS Account
- AWS GitHub role setup to be assumede by OIDC
- DataDog Account
- DataDog API Keys
- GitHub Secrets (AWS_REGION, AWS_ACCOUNT_ID)
