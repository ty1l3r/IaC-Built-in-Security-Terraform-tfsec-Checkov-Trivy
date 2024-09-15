# Environnement pour le VPC (ex: dev, prod)
variable "environment" {
  description = "Environment for the VPC (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

# Plage d'adresses IP pour le VPC
variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# CIDR du sous-réseau public A
variable "cidr_public_subnet_a" {
  description = "CIDR du sous-réseau public A"
  type        = string
  default     = "10.0.128.0/20"
}

# CIDR du sous-réseau public B
variable "cidr_public_subnet_b" {
  description = "CIDR du sous-réseau public B"
  type        = string
  default     = "10.0.144.0/20"
}

# CIDR du sous-réseau privé A
variable "cidr_private_subnet_a" {
  description = "CIDR du sous-réseau privé A"
  type        = string
  default     = "10.0.0.0/19"
}

# CIDR du sous-réseau privé B
variable "cidr_private_subnet_b" {
  description = "CIDR du sous-réseau privé B"
  type        = string
  default     = "10.0.32.0/19"
}

# Zone de disponibilité A
variable "az_a" {
  description = "Zone de disponibilité A"
  default     = "eu-west-3a"
}

# Zone de disponibilité B
variable "az_b" {
  description = "Zone de disponibilité B"
  default     = "eu-west-3b"
}

# Nom de l'Application Load Balancer
variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}

# Les variables commentées sont désactivées car elles sont peut-être redondantes
# variable "public_subnet_a_id" {
#   description = "ID du sous-réseau public A"
#   type        = string
# }

# variable "public_subnet_b_id" {
#   description = "ID du sous-réseau public B"
#   type        = string
# }
