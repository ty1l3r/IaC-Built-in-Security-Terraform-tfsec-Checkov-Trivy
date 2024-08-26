# modules/vpc/variables.tf

# Plage d'adresses IP pour le VPC
variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Plages d'adresses IP pour les sous-réseaux publics
variable "public_subnets" {
  description = "Liste des CIDR blocks pour les sous-réseaux publics"
  type        = list(string)
}

# Plages d'adresses IP pour les sous-réseaux privés
variable "private_subnets" {
  description = "Liste des CIDR blocks pour les sous-réseaux privés"
  type        = list(string)
}

# Zones de disponibilité (AZs) dans lesquelles déployer les sous-réseaux
variable "availability_zones" {
  description = "Liste des zones de disponibilité pour les sous-réseaux"
  type        = list(string)
}
