######### USED

# Output pour l'ID du VPC
output "vpc_id" {
  description = "L'ID du VPC"
  value       = aws_vpc.main_vpc.id
}

# Output pour l'ID du sous-réseau privé A
output "private_subnet_a_id" {
  description = "ID du sous-réseau privé A"
  value       = aws_subnet.private_subnet_a.id
}

# Output pour l'ID du sous-réseau privé B
output "private_subnet_b_id" {
  description = "ID du sous-réseau privé B"
  value       = aws_subnet.private_subnet_b.id
}

# Output pour l'ID du sous-réseau public A
output "public_subnet_a_id" {
  description = "ID du sous-réseau public A"
  value       = aws_subnet.public_subnet_a.id
}

# Output pour l'ID du sous-réseau public B
output "public_subnet_b_id" {
  description = "ID du sous-réseau public B"
  value       = aws_subnet.public_subnet_b.id
}

# Output pour la zone de disponibilité A
output "az_a" {
  description = "Zone de disponibilité A"
  value       = var.az_a
}

# Output pour la zone de disponibilité B
output "az_b" {
  description = "Zone de disponibilité B"
  value       = var.az_b
}

# Output pour l'ID de l'Internet Gateway
output "igw_id" {
  description = "L'ID de l'Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output pour le CIDR du sous-réseau public A
output "cidr_public_subnet_a_output" {
  description = "CIDR du sous-réseau public A"
  value       = var.cidr_public_subnet_a
}

# Output pour le CIDR du sous-réseau public B
output "cidr_public_subnet_b_output" {
  description = "CIDR du sous-réseau public B"
  value       = var.cidr_public_subnet_b
}

