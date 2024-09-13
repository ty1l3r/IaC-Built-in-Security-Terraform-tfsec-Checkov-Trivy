# alb/variables.tf
variable "rds_endpoint" {
  description = "L'endpoint de l'instance RDS"
  type        = string
}


variable "vpc_id" {
  description = "ID du VPC pour l'ALB "
  type        = string
}

variable "public_subnet_a_id" {
  description = "L'ID du sous-réseau public A"
  type        = string
}

variable "public_subnet_b_id" {
  description = "L'ID du sous-réseau public B"
  type        = string
}

variable "web_instance_type" {
  description = "Type d'instance pour les serveurs WordPress"
  type        = string
  default     = "t2.micro"
}

variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "fabien-alb"
}

variable "enable_https" {
  description = "Activer HTTPS pour le ALB"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "ID de l'AMI à utiliser"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
}

# variable "ec2_app_a_id" {
#   description = "ID de l'instance EC2 pour l'application A"
#   type        = string
# }

# variable "ec2_app_b_id" {
#   description = "ID de l'instance EC2 pour l'application A"
#   type        = string
# }

variable "private_wp_sg_id" {
  description = "ID du groupe de sécurité pour les instances WordPress"
  type        = list(string)
}
