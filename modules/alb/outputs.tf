# alb/outputs.tf

output "alb_dns_name" {
  description = "Le nom DNS de l'ALB"
  value       = aws_lb.app.dns_name
}

output "alb_arn" {
  description = "ARN de l'ALB"
  value       = aws_lb.app.arn
}
