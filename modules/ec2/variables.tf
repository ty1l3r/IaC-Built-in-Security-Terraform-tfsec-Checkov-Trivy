# modules/ec2/variables.tf

# Type d'instance pour le Bastion Host
variable "bastion_instance_type" {
  description = "Type d'instance pour le Bastion Host"
  type        = string
  default     = "t2.micro"
}

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

# ID du Security Group pour le Bastion Host
variable "bastion_security_group_id" {
  description = "ID du Security Group pour le Bastion Host"
  type        = string
}

# ID du Security Group pour les instances WordPress
variable "web_security_group_id" {
  description = "ID du Security Group pour les instances WordPress"
  type        = string
}

# ID du sous-réseau public pour le Bastion Host
variable "public_subnet_id" {
  description = "ID du Subnet Public pour déployer le Bastion Host"
  type        = string
}

# ID du sous-réseau privé pour les instances WordPress
variable "private_subnet_id" {
  description = "ID du Subnet Privé pour déployer les instances WordPress"
  type        = string
}
