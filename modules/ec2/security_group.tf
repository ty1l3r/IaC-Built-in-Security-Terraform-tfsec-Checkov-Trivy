resource "aws_security_group" "sg_private_wp" {
  name   = "sg_private_wp"
  vpc_id = var.vpc_id

  tags = {
    Name = "WT-sg-private-wp"
  }

  # Ingress rules (entrées)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Trafic HTTP depuis le sous-réseau privé
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Trafic HTTPS depuis le sous-réseau privé
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [var.bastion_sg_id]  # Utiliser l'ID du groupe de sécurité du Bastion ici
  }

  # Egress rules (sorties)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Autoriser tout le trafic sortant
    cidr_blocks = ["0.0.0.0/0"]
  }
}
