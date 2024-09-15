# ID du VPC où les ressources RDS seront déployées
variable "vpc_id" {
  description = "L'ID du VPC où les ressources RDS seront déployées"
  type        = string
}

# Type d'instance pour RDS
variable "db_instance_class" {
  description = "Type d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"
}

# Nom de la base de données MySQL
variable "db_name" {
  description = "Nom de la base de données MySQL"
  type        = string
  #default     = "fabien-database"
}

# Nom d'utilisateur administrateur pour MySQL
variable "db_username" {
  description = "Nom d'utilisateur administrateur pour MySQL"
  type        = string
  #default     = "admin"
  sensitive   = true
}

# Mot de passe pour l'utilisateur administrateur de MySQL
variable "db_password" {
  description = "Mot de passe pour l'utilisateur administrateur de MySQL"
  type        = string
  sensitive   = true
}

# Nom du groupe de sous-réseaux pour RDS
variable "db_subnet_group" {
  description = "Nom du groupe de sous-réseaux pour RDS"
  type        = any
  default     = "fabien-DBSubnetGroup"
}

# Activer le déploiement Multi-AZ pour haute disponibilité
variable "multi_az" {
  description = "Activer le déploiement Multi-AZ"
  type        = bool
  default     = true
}

# Liste des IDs des sous-réseaux où RDS sera déployé
variable "subnet_ids" {
  description = "Liste des IDs des sous-réseaux où le RDS sera déployé"
  type        = list(string)
}

# Créer une réplique en lecture pour RDS
variable "create_read_replica" {
  description = "Créer une réplique en lecture (true/false)"
  type        = bool
  default     = false
}

# ID du sous-réseau privé A
variable "private_subnet_a_id" {
  description = "ID du sous-réseau privé A"
  type        = string
}

# ID du sous-réseau privé B
variable "private_subnet_b_id" {
  description = "ID du sous-réseau privé B"
  type        = string
}
