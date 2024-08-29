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
