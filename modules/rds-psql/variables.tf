variable "app_name" { default = "myapp" }
variable "environment" { default = "dev" }
variable "db_name" { default = "mydatabase" }
variable "db_username" { default = "admin" }
variable "db_password" { default = "SuperSecurePassword123!" }
variable "vpc_cidr_block" {}
variable "subnet_ids" {}