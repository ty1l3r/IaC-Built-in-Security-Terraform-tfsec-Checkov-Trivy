# rds/variables.tf

variable "db_instance_class" {
  description = "Type d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"  # Instance de type petite pour les tests, à adapter en production
}

variable "db_name" {
  description = "Nom de la base de données MySQL"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Nom d'utilisateur administrateur pour MySQL"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Mot de passe pour l'utilisateur administrateur de MySQL"
  type        = string
  sensitive   = true  # Marquer comme sensible pour ne pas afficher le mot de passe en clair
}

variable "db_subnet_group" {
  description = "Nom du groupe de sous-réseaux pour RDS"
  type        = string
  default     = "my-db-subnet-group"
}

variable "vpc_security_group_ids" {
  description = "Liste des IDs des groupes de sécurité associés à l'instance RDS"
  type        = list(string)
}

variable "multi_az" {
  description = "Activer le déploiement Multi-AZ"
  type        = bool
  default     = true  # Activer par défaut pour la haute disponibilité
}

variable "subnet_ids" {
  description = "Liste des IDs des sous-réseaux où le RDS sera déployé"
  type        = list(string)
}

variable "create_read_replica" {
  description = "Créer une réplique en lecture (true/false)"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "L'ID du VPC où les ressources RDS seront déployées"
  type        = string
}