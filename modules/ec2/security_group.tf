# Groupe de sécurité pour les instances EC2 WordPress
resource "aws_security_group" "sg_private_wp" {
  name   = "sg_private_wp"
  vpc_id = var.vpc_id

  tags = {
    Name = "WT-sg-private-wp"
  }

  # Ingress rules (entrées)

  # Autoriser le trafic HTTP (port 80) venant de l'ALB
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = var.alb_security_group_id  # Autoriser HTTP venant de l'ALB
  }

  # Autoriser le trafic HTTPS (port 443) venant de l'ALB
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = var.alb_security_group_id  # Autoriser HTTPS venant de l'ALB
  }

  # Autoriser SSH (port 22) venant du Bastion
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Autoriser SSH depuis le Bastion
  }

  # Egress rules (sorties)

   # Egress vers RDS (MySQL, port 3306)
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Connexion sortante vers RDS uniquement dans le VPC
  }


    # Permettre tout autre trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser tout autre trafic sortant
  }
}
