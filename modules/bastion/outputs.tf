
# modules/bastion/outputs.tf
output "bastion_sg_id" {
  description = "ID du Security Group pour les instances Bastion"
  value       = aws_security_group.sg_bastion.id
}
