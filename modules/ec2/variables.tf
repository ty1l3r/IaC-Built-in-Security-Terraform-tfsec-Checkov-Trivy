# modules/ec2/variables.tf

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

variable "project" {
  description = "KANGOUROUUUUUUUXX"
  type        = string
}

# Définition des variables pour l'environnement et le projet
variable "environment" {
  description = "Environnement (e.g., dev, prod)"
  type        = string
}

////////////////////////////////

# Type d'instance pour le Bastion Host
variable "bastion_instance_type" {
  description = "Type d'instance pour le Bastion Host"
  type        = string
  default     = "t2.micro"
}


# ID du sous-réseau public pour le Bastion Host
variable "public_subnet_id" {
  description = "ID du Subnet Public pour déployer le Bastion Host"
  type        = string
}

# Type d'instance pour les serveurs WordPress
variable "web_instance_type" {
  description = "Type d'instance pour les serveurs WordPress"
  type        = string
  default     = "t2.micro"
}

# Nombre d'instances WordPress à déployer
variable "web_instance_count" {
  description = "Nombre d'instances pour WordPress"
  type        = number
  default     = 2
}

# ID du Security Group pour les instances WordPress
variable "web_security_group_id" {
  description = "ID du Security Group pour les instances WordPress"
  type        = string
}



# ID du sous-réseau privé pour les instances WordPress
variable "private_subnet_id" {
  description = "ID du Subnet Privé pour déployer les instances WordPress"
  type        = string
}

variable "bastion_security_group_id" {
  description = "ID du Security Group pour le Bastion Host"
  type        = string
}