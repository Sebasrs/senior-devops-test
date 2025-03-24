tags = {
    test = "test"
}

AWS_GITHUB_ROLE_NAME = "github_actions_role"
AWS_ACCOUNT_NUMBER = "33333333333"

app_name = "interview"
environment = "dev"

vpc_cidr_block = "10.90.0.0/16"
public_subnets = [
  "10.90.0.0/20",
  "10.90.16.0/20",
  "10.90.32.0/20"
]
private_subnets = [
  "10.90.48.0/20",
  "10.90.64.0/20",
  "10.90.80.0/20"
]

datadog_api_key = "test_key"
