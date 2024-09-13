# modules/ec2/variables.tf


# variable "private_wp_sg_id" {
#   description = "ID du Security Group du Bastion"
#   type        = list(string)
# }
variable "alb_security_group_id" {
  description = "ID du groupe de sécurité pour l'ALB"
  type        = list(string)
}
variable "bastion_sg_id" {
  description = "ID du Security Group du Bastion"
  type        = list(string)
}
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


variable "private_wp_sg_id" {
  description = "ID du groupe de sécurité privé WordPress"
  type        = string
}
# Type d'instance pour le Bastion Host
variable "app_instance_type" {
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


variable "launch_template_id" {
  description = "ID du template de lancement pour l'ASG"
  type        = string
}

variable "target_group_arn" {
  description = "ARN du groupe cible pour l'ALB"
  type        = string
}

variable "region_name" {
  description = "Nom de la région AWS"
  default     = "eu-west-3"
}