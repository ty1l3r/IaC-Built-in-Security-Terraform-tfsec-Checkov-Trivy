# alb/outputs.tf

output "alb_name" {
  description = "Nom de l'Application Load Balancer"
  value       = var.alb_name
}

output "alb_arn" {
  description = "ARN de l'ALB"
  value       = aws_lb.lb_app.arn
}

output "target_group_name" {
  description = "Nom du groupe cible de l'ALB"
  value       = var.target_group_name
}

output "enable_https" {
  description = "Indique si HTTPS est activé pour l'ALB"
  value       = var.enable_https
}

output "certificate_arn" {
  description = "moncertificat"
  value = var.certificate_arn
}

output "alb_dns_name" {
  description = "Le nom DNS de l'Application Load Balancer"
  value       = aws_lb.lb_app.dns_name
}
