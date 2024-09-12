# variables.tf

##### USE

# variable "enable_https" {
#   description = "Activer HTTPS pour le ALB"
#   type        = bool
#   default     = false
# }

# variable "bastion_sg_id" {
#   description = "Liste des IDs des sous-réseaux où le RDS sera déployé"
#   type        = list(string)
# }

# variable "private_wp_sg_id" {
#   description = "Liste des IDs des Security Groups privés pour les instances WP"
#   type        = list(string)
# }

# Variable pour l'ID du Bastion
variable "bastion_id" {
  description = "L'ID du Bastion"
  type        = string
  default = ""
}

# variable "certificate_arn" {
#   type        = string
#   description = "ARN du certificat SSL pour HTTPS"
#   default     = null  # Définit par défaut à null si aucun certificat n'est fourni
# }

variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "az_a" {
  description = "zone de disponibilité a"
  default     = "eu-west-3a"
}

variable "az_b" {
  description = "zone de disponibilité a"
  default     = "eu-west-3b"
}

variable "cidr_public_subnet_a" {
  description = "CIDR du sous reseaux public a"
  type = string
  default = "10.0.128.0/20"
}

variable "cidr_public_subnet_b" {
  description = "CIDR du sous reseaux public a"
  type = string
  default = "10.0.144.0/20"
}

variable "cidr_private_subnet_a" {
  description = "CIDR du sous reseaux private a"
  type = string
  default = "10.0.0.0/19"
}

variable "cidr_private_subnet_b" {
  description = "CIDR du sous reseaux private b"
  type = string
  default = "10.0.32.0/19"
}

variable "project" {
  description = "fabien-Terraform-Project"
  type        = string
}

# Définition des variables pour l'environnement et le projet
variable "environment" {
  description = "Prod"
  type        = string
}

/////////////

# variables.tf (Module racine)
variable "create_read_replica" {
  description = "Créer une réplique en lecture (true/false)"
  type        = bool
  default     = false  # Par défaut, ne pas créer de réplique en lecture
}


# # Type d'instance pour le Bastion Host
# variable "bastion_instance_type" {
#   description = "Type d'instance pour le Bastion Host"
#   type        = string
#   default     = "t2.micro"
# }

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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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

/*
variable "vpc_id" {
  description = "Id du VPC par défaut"
  type        = string
  default     = "vpc-075d7129a250b342d"
}*/