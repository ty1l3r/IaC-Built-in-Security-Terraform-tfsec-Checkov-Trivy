# NET VERS LE BASTION
# Groupe de sécurité pour ALB (Application Load Balancer)
resource "aws_security_group" "alb" {
  name        = "Fabien-alb_security_group"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # A RETIRER APRES LA GESTION DU HTTPS
  # Autoriser HTTP depuis n'importe où (Internet)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP depuis n'importe où
  }

  # Autoriser HTTPS depuis n'importe où (Internet)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTPS depuis n'importe où
  }

  # Restreindre le trafic sortant uniquement vers les sous-réseaux privés pour HTTP (port 80)
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]  # Trafic HTTP vers les sous-réseaux privés (instances EC2)
  }

  # Restreindre le trafic sortant uniquement vers les sous-réseaux privés pour HTTPS (port 443)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]  # Trafic HTTPS vers les sous-réseaux privés (instances EC2)
  }

  tags = {
    Name = "Fabien-ALBSecurityGroup"
  }
}
