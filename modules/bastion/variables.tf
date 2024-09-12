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


variable "key_name" {
  description = "Nom de la clé SSH pour accéder à l'instance Bastion"
  type        = string
}

