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

# ID du Security Group pour les instances WordPress
variable "wp_security_group_id" {
  description = "ID du Security Group pour les instances WordPress"
  type        = string
}



############### TEST

/*

# ID du sous-réseau public pour le Bastion Host
variable "public_subnet_id" {
  description = "ID du Subnet Public pour déployer le Bastion Host"
  type        = string
}

variable "bastion_security_group_id" {
  description = "ID du Security Group pour le Bastion Host"
  type        = string
}

# ID du sous-réseau privé pour les instances WordPress
variable "private_subnet_id" {
  description = "ID du Subnet Privé pour déployer les instances WordPress"
  type        = string
}

# Définition des variables pour les clés SSH du Bastion Host
variable "ec2_bastion_public_key_path" {
  description = "Chemin pour enregistrer la clé publique"
  type        = string
}

variable "ec2_bastion_private_key_path" {
  description = "Chemin pour enregistrer la clé privée"
  type        = string
}

variable "ec2_bastion_ingress_ip_1" {
  description = "IP autorisée pour l'accès SSH au Bastion Host"
  type        = string
}




*/














////////////////////////////////








