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
  description = "ARN du certificat SSL à utiliser pour HTTPS"
  type        = string
  default     = null  # Par défaut, pas de certificat externe
}

variable "ec2_app_a_id" {
  description = "ID de l'instance EC2 pour l'application A"
  type        = string
}

variable "ec2_app_b_id" {
  description = "ID de l'instance EC2 pour l'application A"
  type        = string
}

############################# a voir

/*


variable "instance_ids" {
  description = "Liste des IDs des instances EC2 à enregistrer dans le groupe cible"
  type        = list(string)
}
*/



