# alb/variables.tf

variable "vpc_id" {
  description = "L'ID du VPC où le ALB sera déployé"
  type        = string
}

variable "public_subnets" {
  description = "Liste des IDs des sous-réseaux publics où le ALB sera déployé"
  type        = list(string)
}

variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "target_group_name" {
  description = "Nom du groupe cible"
  type        = string
  default     = "my-target-group"
}

variable "instance_ids" {
  description = "Liste des IDs des instances EC2 à enregistrer dans le groupe cible"
  type        = list(string)
}

variable "enable_https" {
  description = "Activer HTTPS pour le ALB"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ARN du certificat SSL à utiliser pour HTTPS"
  type        = string
  default     = ""
}
