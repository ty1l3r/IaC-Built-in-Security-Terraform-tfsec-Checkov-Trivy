output "bastion_ids" {
  description = "Liste des IDs des instances Bastion"
  value       = length(aws_instance.bastion) > 0 ? aws_instance.bastion[*].id : []
}

# modules/bastion/outputs.tf
output "bastion_sg_id" {
  value = aws_security_group.sg_bastion.id
}

