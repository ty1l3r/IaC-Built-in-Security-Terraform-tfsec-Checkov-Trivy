output "vpc_id" {
  description = "ID du VPC créé"
  value       = module.vpc.vpc_id  
}

output "vpc_cidr" {
  description = "CIDR block du VPC"
  value       = var.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs des subnets publics"
  value       = module.vpc.public_subnet_ids 
}

output "private_subnet_ids" {
  description = "IDs des subnets privés"
  value       = module.vpc.private_subnet_ids  
}

output "internet_gateway_id" {
  description = "ID de la passerelle internet"
  value       = module.vpc.igw_id  
}