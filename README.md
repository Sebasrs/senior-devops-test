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
- ECR Repository to push the docker image

# Deployment
Most configuration are already taken care of, we assume you have the following pieces:
- AWS Account
- AWS GitHub role setup to be assumede by OIDC
- DataDog Account
- DataDog API Keys
- GitHub Secrets (AWS_REGION, AWS_ACCOUNT_ID)

## Steps
- Fill in all variables in environments with the correct values
- Tag the trunk branch (main or any other designed to be) with the correct tag to trigger the workflow
  + environment-infrastructure* to deploy the env
  + environment-app* to deploy the app
    * *The order matters, the k8s need to be created first so run infrastructure, fill CLUSTER_NAME github secret with the cluster name after creation

# Decisions
Created 2 different deployments so we can deploy the app and infrastructure separately.

Added in the external secrets operator so the app can actually gather secrets from the secrets manager service.

Created and RDS clusters with minimal resources so we keep it cheap until we make it to productions.

Add in DD as a Helm Chart in the same IaC.

Created a /16 VPC and /20 Subnets so we have 4096 IPs for each subnet, 3 public and 3 private to start with.

Attached private subnets to RDS and EKS so it can only be privately accesible.

Added a load balancer to the go app Helm Chart so it actually is accesed by this method only and interface between the public and private subnet securely.

We use Terraform workspaces to keep the infrastructure separate in differente statefiles.

We use S3 as a backend for our Terraform statefile.

# Improvements
Since I did not have much time for this we can implemente the following improvements so this is more like a real world solution:
- Use paramenters store and secrets manager to manage environment values for each Terraform workspace.
- Create a DynamoDB table to lock the statefile so it's easier to collaborate.
- Seek the db connection string from the remote statefile or secrets manager so its automatic we avoid adding it in the github secrets manually.
- I would actually prefere a GitOps approach using ArgoCD instead of just applying the helm chart via cicd.
- Use Terragrunt which makes a little easier managing multiple environments and big Terraform projects.
- Setup DataDog monitors and alerts.
- Add more options to the DataDog terraform module such as independent container insight, custom monitors already built.
