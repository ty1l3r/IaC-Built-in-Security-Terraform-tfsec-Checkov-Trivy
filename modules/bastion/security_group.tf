resource "aws_security_group" "sg_bastion" {
  name   = "sg_22-WT"
  vpc_id = var.vpc_id
   tags = {
    Name = "WT-sg-22"
  }

  # Autoriser SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # CIDR du sous-réseau des instances EC2
  }
}
