# modules/ec2/ami.tf

# Récupérer l'AMI Amazon Linux 2 la plus récente disponible
data "aws_ami" "latest_amazon_linux" {
  most_recent = true  # Indique que nous voulons l'AMI la plus récente

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filtre pour les AMIs Amazon Linux 2
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]  # Utilisation de la virtualisation HVM (Hardware Virtual Machine)
  }

  owners = ["amazon"]  # Restreindre la recherche aux AMIs publiées par Amazon
}