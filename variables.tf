# Setup vars
variable "tags" {
  description = "Default tags for all resources"
}

variable "AWS_GITHUB_ROLE_NAME" {}
variable "AWS_ACCOUNT_NUMBER" {}

variable "app_name" {}
variable "environment" {}

# VPC
variable "vpc_cidr_block" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

# Datadog
variable "datadog_api_key" {}