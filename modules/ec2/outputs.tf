# modules/ec2/outputs.tf

# Output pour récupérer l'ID du Bastion Host
output "bastion_instance_id" {
  description = "L'ID de l'instance Bastion"
  value       = aws_instance.bastion.id
}

# Output pour récupérer l'adresse IP publique du Bastion Host
output "bastion_public_ip" {
  description = "L'adresse IP publique de l'instance Bastion"
  value       = aws_instance.bastion.public_ip
}

# Output pour récupérer les IDs des instances WordPress
output "web_instance_ids" {
  description = "Les IDs des instances WordPress"
  value       = aws_instance.web_private[*].id
}

# Output pour récupérer les adresses IP privées des instances WordPress
output "web_private_ips" {
  description = "Les adresses IP privées des instances WordPress"
  value       = aws_instance.web_private[*].private_ip
}
