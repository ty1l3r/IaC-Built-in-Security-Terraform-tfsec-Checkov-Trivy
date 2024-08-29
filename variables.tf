# variables.tf

/////////////
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

/////////////

# variables.tf (Module racine)
variable "create_read_replica" {
  description = "Créer une réplique en lecture (true/false)"
  type        = bool
  default     = false  # Par défaut, ne pas créer de réplique en lecture
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

# Nombre d'instances WordPress à déployer
variable "web_instance_count" {
  description = "Nombre d'instances pour WordPress"
  type        = number
  default     = 2
}

# ID du Security Group pour le Bastion Host
variable "bastion_security_group_id" {
  description = "ID du Security Group pour le Bastion Host"
  type        = string
}

# ID du Security Group pour les instances WordPress
variable "web_security_group_id" {
  description = "ID du Security Group pour les instances WordPress"
  type        = string
}

# ID du sous-réseau public pour le Bastion Host
variable "public_subnet_id" {
  description = "ID du Subnet Public pour déployer le Bastion Host"
  type        = string
}

# ID du sous-réseau privé pour les instances WordPress
variable "private_subnet_id" {
  description = "ID du Subnet Privé pour déployer les instances WordPress"
  type        = string
}

# Zones de disponibilité (AZs) dans lesquelles déployer les sous-réseaux
variable "availability_zones" {
  description = "Liste des zones de disponibilité pour les sous-réseaux"
  type        = list(string)
  default     = [
    "eu-west-3a",  # AZ 1
    "eu-west-3b"   # AZ 2
  ]
}

variable "multi_az" {
  description = "Activer le déploiement Multi-AZ"
  type        = bool
  default     = true  # Activer par défaut pour la haute disponibilité
}

variable "db_instance_class" {
  description = "Type d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"  # Vous pouvez ajuster cette valeur selon vos besoins
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_subnet_group" {
  description = "Nom du groupe de sous-réseaux pour RDS"
  type        = any
  default     = "my-db-subnet-group"
}

variable "vpc_security_group_name" {
  description = "Nom du Security Group pour le VPC"
  type        = string
  default     = "vpc_security_group"  # Vous pouvez définir un nom par défaut ici
}

