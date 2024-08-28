resource "aws_security_group" "vpc" {
  name        = "vpc_security_group"
  description = "Groupe de sécurité par défaut pour le VPC"
  vpc_id      = aws_vpc.main.id  # Supposant que vous avez une ressource VPC dans ce module

  # Règles d'entrée et de sortie (à adapter selon vos besoins)
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DefaultSecurityGroup"
  }
}