# modules/vpc/variables.tf



variable "environment" {
  description = "Environment for the VPC (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

# Plage d'adresses IP pour le VPC
variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/20"
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

variable "az_a" {
  description = "zone de disponibilité a"
  default     = "eu-west-3a"
}

variable "az_b" {
  description = "zone de disponibilité a"
  default     = "eu-west-3b"
}

variable "alb_name" {
  description = "Nom de l'Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "public_subnet_a_id" {
  description = "ID du sous-réseau public A"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID du sous-réseau public B"
  type        = string
}
