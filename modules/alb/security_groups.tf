# alb/security_groups.tf

resource "aws_security_group" "alb" {
  name        = "alb_security_group"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Règles d'entrée pour HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser le trafic de n'importe où
  }

  # Règles d'entrée pour HTTPS (port 443), seulement si HTTPS est activé
  dynamic "ingress" {
    for_each = var.enable_https ? [1] : []
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Autoriser le trafic de n'importe où
    }
  }

  # Règles de sortie, autorisant tout trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALBSecurityGroup"
  }
}
