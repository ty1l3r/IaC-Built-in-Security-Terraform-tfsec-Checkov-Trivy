# modules/ec2/security-group.tf (par exemple)
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = var.aws_vpc.main.id

  ingress {
    from_port   = 22  # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ec2_bastion_ingress_ip_1]  # Autorise SSH depuis une IP spécifique
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Autorise tout le trafic sortant
  }

  tags = {
    Name = "${var.project}-bastion-sg"
  }
}
