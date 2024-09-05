# modules/ec2/variables.tf


############### USED

# Variable pour l'ID du sous-réseau privé A
variable "private_subnet_a_id" {
  description = "L'ID du sous-réseau privé A"
  type        = string
}

# Variable pour l'ID du sous-réseau privé B
variable "private_subnet_b_id" {
  description = "L'ID du sous-réseau privé B"
  type        = string
}

variable "vpc_id" {
  description = "L'ID du VPC dans lequel les ressources EC2 seront créées"
  type        = string
}

# Type d'instance pour le Bastion Host
variable "bastion_instance_type" {
  description = "Type d'instance pour le Bastion Host"
  type        = string
  default     = "t2.micro"
}

# Type d'instance pour les serveurs WordPress
variable "web_instance_type" {
  description = "Type d'instance pour les serveurs WordPress"
  type        = string
  default     = "t2.micro"
}

variable "project" {
  description = "KANGOUROUUUUUUUXX"
  type        = string
}

# Définition des variables pour l'environnement et le projet
variable "environment" {
  description = "Environnement (e.g., dev, prod)"
  type        = string
}


