# outputs.tf

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
