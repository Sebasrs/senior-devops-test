# Setup vars
variable "tags" {
  description = "Default tags for all resources"
}

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

variable "datadog_api_key" {}