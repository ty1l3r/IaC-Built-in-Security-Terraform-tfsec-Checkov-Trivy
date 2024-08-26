variable "aws_region" {
  description = "Région AWS où l'infrastructure sera déployée"
  type        = string
  default     = "eu-west-3"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "example-project"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "Liste des CIDR blocks pour les subnets publics"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "Liste des CIDR blocks pour les subnets privés"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "Liste des zones de disponibilité à utiliser"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
}
variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}