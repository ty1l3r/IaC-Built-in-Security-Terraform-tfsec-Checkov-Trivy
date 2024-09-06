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

variable "vpc_security_group_ids" {
  description = "Liste des IDs des Security Groups du VPC"
  type        = list(string)
}


variable "certificate_arn" {
  description = "ARN du certificat SSL à utiliser pour le Bastion"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé SSH pour accéder à l'instance Bastion"
  type        = string
}

variable "subnet_id" {
  description = "Liste des IDs des sous-réseaux où le RDS sera déployé"
  type        = list(string)
}
