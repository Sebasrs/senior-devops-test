tags = {
    test = "test"
}

app_name = "interview"
environment = "dev"

vpc_cidr_block = "10.70.0.0/16"
public_subnets = [
  "10.70.0.0/20",
  "10.70.16.0/20",
  "10.70.32.0/20"
]
private_subnets = [
  "10.70.48.0/20",
  "10.70.64.0/20",
  "10.70.80.0/20"
]

datadog_api_key = "test_key"
