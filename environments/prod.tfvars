tags = {
    test = "test"
}

app_name = "interview"
environment = "dev"

vpc_cidr_block = "10.80.0.0/16"
public_subnets = [
  "10.80.0.0/20",
  "10.80.16.0/20",
  "10.80.32.0/20"
]
private_subnets = [
  "10.80.48.0/20",
  "10.80.64.0/20",
  "10.80.80.0/20"
]

datadog_api_key = "test_key"
