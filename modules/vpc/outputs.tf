# modules/vpc/outputs.tf

######### USED

# Output pour l'ID du VPC ( créé par "igw")
output "vpc_id" {
  description = "L'ID du VPC"
  value       = aws_vpc.main_vpc.id
}

# Output pour l'ID du sous-réseau privé A
output "private_subnet_a_id" {
  description = "L'ID du sous-réseau privé A"
  value       = aws_subnet.private_subnet_a.id
}

# Output pour l'ID du sous-réseau privé B
output "private_subnet_b_id" {
  description = "L'ID du sous-réseau privé B"
  value       = aws_subnet.private_subnet_b.id
}

output "public_subnet_a_id" {
  description = "L'ID du sous-réseau public A"
  value       = aws_subnet.public_subnet_a.id
}

output "public_subnet_b_id" {
  description = "L'ID du sous-réseau public B"
  value       = aws_subnet.public_subnet_b.id
}

output "az_a" {
  description = "Zone de disponibilité A"
  value       = var.az_a
}

output "az_b" {
  description = "Zone de disponibilité B"
  value       = var.az_b
}

######### A VOIR

# Output pour l'ID de l'Internet Gateway
output "igw_id" {
  description = "L'ID de l'Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output pour l'ID de l'Internet Gateway A
output "cidr_public_subnet_a_output" {
  description = "CIDR du sous-réseau public A"
  value       = var.cidr_public_subnet_a
}

# Output pour l'ID de l'Internet Gateway B
output "cidr_public_subnet_b_output" {
  description = "CIDR du sous-réseau public B"
  value       = var.cidr_public_subnet_b
}

/*
# Output pour les IDs des NAT Gateways
output "nat_ids" {
  description = "Les IDs des NAT Gateways"
  value       = aws_nat_gateway.nat[*].id
}

# Output pour l'ID du Security Group par défaut pour le VPC
output "vpc_security_group_ids" {
  description = "Les IDs du Security Group par défaut pour le VPC"
  value       = [aws_security_group.vpc.id]
}

output "vpc_security_group_id" {
  description = "ID of the VPC security group"
  value       = aws_security_group.vpc.id
}
*/




