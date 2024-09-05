# alb/variables.tf

############################# utilisés sûr

variable "vpc_id" {
  description = "L'ID du VPC où le ALB sera déployé"
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

variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}


variable "enable_https" {
  description = "Activer HTTPS pour le ALB"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  type        = string
  description = "ARN du certificat SSL pour HTTPS"
  default     = null  # Définit par défaut à null si aucun certificat n'est fourni
}

variable "ec2_app_a_id" {
  description = "ID de l'instance EC2 pour l'application A"
  type        = string
}

variable "ec2_app_b_id" {
  description = "ID de l'instance EC2 pour l'application A"
  type        = string
}

variable "create_key_pair" {
  description = "Indique si la Key Pair doit être créée"
  default     = false
}
