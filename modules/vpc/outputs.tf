# modules/vpc/outputs.tf

# Output pour l'ID du VPC
output "vpc_id" {
  description = "L'ID du VPC"
  value       = aws_vpc.main.id
}

# Output pour les IDs des sous-réseaux publics
output "public_subnet_ids" {
  description = "Les IDs des sous-réseaux publics"
  value       = aws_subnet.public[*].id
}

# Output pour les IDs des sous-réseaux privés
output "private_subnet_ids" {
  description = "Les IDs des sous-réseaux privés"
  value       = aws_subnet.private[*].id
}

# Output pour l'ID de l'Internet Gateway
output "igw_id" {
  description = "L'ID de l'Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output pour l'ID de la NAT Gateway
output "nat_id" {
  description = "L'ID de la NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}


output "vpc_security_group_ids" {
  description = "L'ID du Security Group par défaut pour le VPC"
  value       = aws_security_group.vpc.id
}