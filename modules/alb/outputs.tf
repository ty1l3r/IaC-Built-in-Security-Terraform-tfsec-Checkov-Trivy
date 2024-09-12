# output "alb_name" {
#   description = "Nom de l'Application Load Balancer"
#   value       = var.alb_name
# }

# output "alb_arn" {
#   description = "ARN de l'ALB"
#   value       = aws_lb.lb_app.arn
# }

output "target_group_name" {
  description = "Nom du groupe cible de l'ALB"
  value       = aws_lb_target_group.app_vms.name
}
output "wordpress_launch_template_id" {
  description = "ID du template de lancement pour l'ASG"
  value       = aws_launch_template.wordpress.id
}

output "target_group_arn" {
  description = "ARN du groupe cible pour l'ALB"
  value       = aws_lb_target_group.app_vms.arn
}
# output "enable_https" {
#   description = "Indique si HTTPS est activé pour l'ALB"
#   value       = var.enable_https
# }

# output "alb_dns_name" {
#   description = "Le nom DNS de l'Application Load Balancer"
#   value       = aws_lb.lb_app.dns_name
# }

# modules/alb/outputs.tf
# output "myec2key_name" {
#   description = "Nom de la paire de clés SSH"
#   value       = aws_key_pair.myec2key.key_name
# }

