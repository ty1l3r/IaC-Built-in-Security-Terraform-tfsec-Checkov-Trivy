# === Security Group pour les Bastions Hosts ===
resource "aws_security_group" "sg_bastion" {
  name   = "sg_bastion"
  vpc_id = var.vpc_id

  tags = {
    Name = "WT-sg-bastion"
  }

  # Autoriser SSH depuis n'importe où (Internet)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser SSH depuis n'importe où (Internet)
  }

  # Autoriser tout autre trafic sortant (par défaut, on ne restreint pas)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Tous les protocoles
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser tout le trafic sortant
  }
}
