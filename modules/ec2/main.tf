# modules/ec2/main.tf

## Création de la paire de clé du serveur Bastion
resource "aws_key_pair" "myec2key" {
  key_name   = "keypair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Instance EC2 pour WordPress - Déployée dans un sous-réseau privé A
resource "aws_instance" "ec2_app_a" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.private_subnet_a_id
  #wp_security_group_id = [aws_security_group.sg_private_wp.id]
  key_name               = aws_key_pair.myec2key.key_name
  user_data = "${file("wp.sh")}"
  tags = {
    Name        = "app_wp_a"
  }
}

# Instance EC2 pour WordPress - Déployée dans un sous-réseau privé b
resource "aws_instance" "ec2_app_b" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.private_subnet_b_id
  #wp_security_group_id = [aws_security_group.sg_private_wp.id]
  key_name               = aws_key_pair.myec2key.key_name
  user_data = "${file("wp.sh")}"
  tags = {
    Name        = "app_wp_b"
  }
}

## AUTOSCALLING #############################################################

# Auto Scaling Group pour gérer les instances WordPress
resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = aws_launch_configuration.web_lc.id  # Correction ici
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1  # Vous pouvez ajuster ce nombre selon vos besoins initiaux
  vpc_zone_identifier  = [var.private_subnet_a_id, var.private_subnet_b_id]  # Utiliser les deux sous-réseaux privés

  tag {
    key                 = "Name"
    value               = "WordPress-Private-EC2-ASG"
    propagate_at_launch = true
  }
}

# Configuration de lancement utilisée par le groupe d'autoscaling (ASG)
resource "aws_launch_configuration" "web_lc" {
  image_id        = data.aws_ami.latest_amazon_linux.id  # Utilise l'AMI récupérée dans ami.tf
  instance_type   = var.web_instance_type  # Type d'instance pour les serveurs WordPress
  security_groups = [var.wp_security_group_id]  # Le Security Group pour ces instances

  lifecycle {
    create_before_destroy = true  # Assure que la nouvelle configuration est créée avant que l'ancienne ne soit détruite
  }
}
