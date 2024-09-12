# modules/ami/main.tf

# Récupère la dernière AMI Amazon Linux 2 disponible
data "aws_ami" "amazon_linux_latest" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filtre pour les AMI Amazon Linux 2
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]  # Virtualisation HVM
  }
  owners = ["amazon"]  # Restreint aux AMIs publiées par Amazon
}
