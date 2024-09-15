# Sortie de l'ID du security group de l'ALB
output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

# Sortie du nom du groupe cible de l'ALB
output "target_group_name" {
  description = "Nom du groupe cible de l'ALB"
  value       = aws_lb_target_group.app_vms.name
}

# Sortie de l'ID du template de lancement pour l'Auto Scaling Group (ASG)
output "wordpress_launch_template_id" {
  description = "ID du template de lancement pour l'ASG"
  value       = aws_launch_template.wordpress.id
}

# Sortie de l'ARN du groupe cible de l'ALB
output "target_group_arn" {
  description = "ARN du groupe cible pour l'ALB"
  value       = aws_lb_target_group.app_vms.arn
}
