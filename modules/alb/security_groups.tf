resource "aws_security_group" "alb" {
  name        = "alb_security_group-WT"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Autoriser HTTP et HTTPS depuis n'importe où
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser HTTP depuis n'importe où (Internet)
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser HTTPS depuis n'importe où (Internet)
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Autoriser tout le trafic sortant
  }

  tags = {
    Name = "WT-ALBSecurityGroup"
  }
}
