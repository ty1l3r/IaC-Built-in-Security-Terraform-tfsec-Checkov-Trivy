# modules/ec2/outputs.tf

##################### USEFULL

output "ec2_app_a_id" {
  description = "ID de l'instance EC2 pour WordPress dans le sous-réseau privé A"
  value       = aws_instance.ec2_app_a.id
}

output "ec2_app_b_id" {
  description = "ID de l'instance EC2 pour WordPress dans le sous-réseau privé B"
  value       = aws_instance.ec2_app_b.id
}

output "wp_security_group_id" {
  description = "ID du Security Group pour les instances WordPress"
  value       = aws_security_group.sg_private_wp
}



