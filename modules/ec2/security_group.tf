# Groupe de sécurité pour les instances EC2 WordPress
resource "aws_security_group" "sg_private_wp" {
  name   = "sg_private_wp"
  vpc_id = var.vpc_id

  tags = {
    Name = "Fabien-sg-private-wp"
  }

  # Ingress rules (entrées)

  #DESACTIVER APRES LA GESTION DE L'HTTPS
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
    #cidr_blocks = ["10.0.0.0/16"]  # Autoriser SSH depuis le Bastion
    security_groups = var.bastion_sg_id
  }

  # Egress rules (sorties)

  # Egress vers RDS (MySQL, port 3306) — toujours permissif pour déboguer
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # REDIRIGER VERS LE GROUPE DE SECURITE DU BASTION OU IP RESEAU PRIVES
    cidr_blocks = ["10.0.0.0/19"]
    #cidr_blocks = ["0.0.0.0/0"]  # Permissif : DEBUG
  }

  # Egress SSH (port 22) sortant — autorisation de SSH sortant (vers Bastion ou autre)
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # Permissif : SSH sortant
    security_groups = var.bastion_sg_id
  }

  # Permettre tout autre trafic sortant (par défaut)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permettre tout autre trafic sortant
  }
}