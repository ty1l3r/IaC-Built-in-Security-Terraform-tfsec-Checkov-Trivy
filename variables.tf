# ID du Bastion
variable "bastion_id" {
  description = "L'ID du Bastion"
  type        = string
  default     = ""
}

# Nom de l'ALB
variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}

# Zone de disponibilité A
variable "az_a" {
  description = "zone de disponibilité a"
  default     = "eu-west-3a"
}

# Zone de disponibilité B
variable "az_b" {
  description = "zone de disponibilité b"
  default     = "eu-west-3b"
}

# CIDR sous-réseau public A
variable "cidr_public_subnet_a" {
  description = "CIDR du sous reseaux public a"
  type        = string
  default     = "10.0.128.0/20"
}

# CIDR sous-réseau public B
variable "cidr_public_subnet_b" {
  description = "CIDR du sous reseaux public b"
  type        = string
  default     = "10.0.144.0/20"
}

# CIDR sous-réseau privé A
variable "cidr_private_subnet_a" {
  description = "CIDR du sous reseaux private a"
  type        = string
  default     = "10.0.0.0/19"
}

# CIDR sous-réseau privé B
variable "cidr_private_subnet_b" {
  description = "CIDR du sous reseaux private b"
  type        = string
  default     = "10.0.32.0/19"
}

# Nom du projet
variable "project" {
  description = "fabien-Terraform-Project"
  type        = string
}

# Environnement (ex: Prod)
variable "environment" {
  description = "Prod"
  type        = string
}

# Créer réplique en lecture
variable "create_read_replica" {
  description = "Créer une réplique en lecture (true/false)"
  type        = bool
  default     = false
}

# Type instance WordPress
variable "web_instance_type" {
  description = "Type d'instance pour les serveurs WordPress"
  type        = string
  default     = "t2.micro"
}

# Nombre instances WordPress
variable "web_instance_count" {
  description = "Nombre d'instances pour WordPress"
  type        = number
  default     = 2
}

# Liste des AZs
variable "availability_zones" {
  description = "Liste des zones de disponibilité pour les sous-réseaux"
  type        = list(string)
  default     = [
    "eu-west-3a",  # AZ 1
    "eu-west-3b"   # AZ 2
  ]
}

# Activer Multi-AZ
variable "multi_az" {
  description = "Activer le déploiement Multi-AZ"
  type        = bool
  default     = true
}

# Type d'instance RDS
variable "db_instance_class" {
  description = "Type d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"
}

# CIDR bloc du VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Nom de la base de données
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "wordpressdb"
}

# Nom utilisateur RDS
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

# Mot de passe RDS
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

# Groupe sous-réseaux RDS
variable "db_subnet_group" {
  description = "Nom du groupe de sous-réseaux pour RDS"
  type        = any
  default     = "my-db-subnet-group"
}

# Nom du security group VPC
variable "vpc_security_group_name" {
  description = "Nom du Security Group pour le VPC"
  type        = string
  default     = "vpc_security_group"
}
