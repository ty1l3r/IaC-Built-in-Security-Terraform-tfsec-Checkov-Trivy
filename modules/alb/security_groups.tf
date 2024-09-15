# Groupe de sécurité pour ALB (Application Load Balancer)
resource "aws_security_group" "alb" {
  name        = "alb_security_group-WT"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

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

    # Egress vers les sous-réseaux privés (pour atteindre les instances EC2 WordPress)
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]  # Envoyer le trafic HTTP vers les instances EC2
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser tout le trafic sortant
  }
  tags = {
    Name = "WT-ALBSecurityGroup"
  }
}
