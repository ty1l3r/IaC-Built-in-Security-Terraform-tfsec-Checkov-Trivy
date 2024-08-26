aws_region = "eu-west-3"
project_name = "my-awesome-project"
environment = "dev"

vpc_cidr = "10.0.0.0/16"
public_subnets_cidr = [
  "10.0.128.0/20",
  "10.0.144.0/20"
]
private_subnets_cidr = [
  "10.0.0.0/19",
  "10.0.32.0/19"
]
availability_zones = [
  "eu-west-3a",
  "eu-west-3b"
]
