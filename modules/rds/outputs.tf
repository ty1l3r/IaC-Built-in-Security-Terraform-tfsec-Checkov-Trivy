# rds/outputs.tf

output "rds_endpoint" {
  description = "L'endpoint de l'instance RDS principale"
  value       = aws_db_instance.main.endpoint
}

output "rds_read_replica_endpoint" {
  value = var.create_read_replica ? aws_db_instance.read_replica[0].endpoint : ""
}
