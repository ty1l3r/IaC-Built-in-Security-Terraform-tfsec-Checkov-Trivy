resource "aws_security_group" "sg_bastion" {
  name   = "sg_bastion"
  vpc_id = var.vpc_id

  tags = {
    Name = "WT-sg-bastion"
  }

  # Autoriser SSH depuis l'Internet (pour l'administrateur)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permettre les connexions SSH depuis n'importe où
  }

  # Egress vers les instances EC2 privées dans les sous-réseaux privés
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]  # Autoriser SSH vers les sous-réseaux privés
  }

  # Permettre tout autre trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permettre tout autre trafic sortant
  }
}
