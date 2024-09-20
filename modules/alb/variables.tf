# Endpoint de l'instance RDS
variable "db_username" {
  type      = string
  description = "Entrer le nom de la BDD"
  sensitive = true
}
variable "db_password" {
  type      = string
  description = "Mot de passe de la base de donné (8 caractères min)"
  sensitive = true
}

variable "rds_endpoint" {
  description = "L'endpoint de l'instance RDS"
  type        = string
}

# ID du VPC pour l'ALB
variable "vpc_id" {
  description = "ID du VPC pour l'ALB"
  type        = string
}

# ID du sous-réseau public A
variable "public_subnet_a_id" {
  description = "L'ID du sous-réseau public A"
  type        = string
}

# ID du sous-réseau public B
variable "public_subnet_b_id" {
  description = "L'ID du sous-réseau public B"
  type        = string
}

# Type d'instance WordPress
variable "web_instance_type" {
  description = "Type d'instance pour les serveurs WordPress"
  type        = string
  default     = "t2.micro"
}

# Nom de l'ALB
variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "fabien-alb"
}

# Activer ou désactiver HTTPS
variable "enable_https" {
  description = "Activer HTTPS pour le ALB"
  type        = bool
  default     = false
}

# ID de l'AMI
variable "ami_id" {
  description = "ID de l'AMI à utiliser"
  type        = string
}

# Nom de la clé SSH
variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
}

# ID du groupe de sécurité WordPress
variable "private_wp_sg_id" {
  description = "ID du groupe de sécurité pour les instances WordPress"
  type        = list(string)
}
