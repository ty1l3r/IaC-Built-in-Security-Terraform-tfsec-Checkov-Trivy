resource "aws_security_group" "rds" {
  name        = "rds_security_group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  # Autoriser MySQL depuis les sous-réseaux privés (instances EC2 WordPress)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]  # Assurer l'accès MySQL depuis les instances EC2 privées
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
