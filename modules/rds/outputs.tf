# rds/outputs.tf

# Output de l'ID du groupe de sous-réseaux RDS
output "db_subnet_group" {
  value       = aws_db_subnet_group.db_subnet_group
  description = "Nom du groupe de sous-réseaux pour l'instance RDS"
}

# Output du nom de la base de données
output "db_name" {
  value       = var.db_name
  description = "Nom de la base de données MySQL"
}

# Output de l'instance RDS principale
output "rds_instance_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "Endpoint de l'instance RDS principale"
}

output "rds_read_replica_endpoint" {
  value       = var.create_read_replica ? aws_db_instance.read_replica[0].endpoint : null
  description = "Endpoint de la réplique en lecture, si créée"
}

# Output de l'ID du VPC
output "vpc_id" {
  value       = var.vpc_id
  description = "L'ID du VPC où les ressources RDS sont déployées"
}

# Output des IDs des sous-réseaux utilisés par RDS
output "subnet_ids" {
  value       = aws_db_subnet_group.db_subnet_group.id
  description = "Liste des IDs des sous-réseaux où le RDS est déployé"
}

# Output du type d'instance RDS
output "db_instance_class" {
  value       = var.db_instance_class
  description = "Type d'instance pour RDS"
}

# Output de la configuration Multi-AZ
output "multi_az" {
  value       = var.multi_az
  description = "Indique si le déploiement Multi-AZ est activé"
}
output "rds_endpoint" {
  value = aws_db_instance.main.address
  description = "The RDS instance endpoint"
}
