resource "aws_security_group" "sg_private_wp" {
  name   = "sg_private_wp"
  vpc_id = var.vpc_id

  tags = {
    Name = "WT-sg-private-wp"
  }

  # Ingress rules (entrées)

  # Autoriser le trafic HTTP (port 80) depuis n'importe où (Internet)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser HTTP depuis n'importe où (Internet)
  }

  # Autoriser le trafic HTTPS (port 443) depuis n'importe où (Internet)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser HTTPS depuis n'importe où (Internet)
  }

  # Autoriser SSH (port 22) depuis n'importe où (Internet)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser SSH depuis n'importe où (Internet)
  }

  # Egress rules (sorties)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Autoriser tout le trafic sortant
    cidr_blocks = ["0.0.0.0/0"]
  }
}
