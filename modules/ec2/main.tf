# modules/ec2/main.tf

# Bastion Host - Instance EC2 déployée dans un sous-réseau public
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.latest_amazon_linux.id  # Utilise l'AMI récupérée dans ami.tf
  instance_type = var.bastion_instance_type  # Type d'instance pour le Bastion Host

  vpc_security_group_ids = [var.bastion_security_group_id]  # Le Security Group pour le Bastion Host
  subnet_id              = var.public_subnet_id  # Le sous-réseau public où le Bastion sera déployé

  associate_public_ip_address = true  # Associe une adresse IP publique pour permettre l'accès depuis Internet

  tags = {
    Name = "Bastion-Host"  # Un tag pour identifier cette instance comme le Bastion Host
  }
}

# Instances EC2 pour WordPress - Déployées dans des sous-réseaux privés
resource "aws_instance" "web_private" {
  count         = var.web_instance_count  # Le nombre d'instances WordPress à créer
  ami           = data.aws_ami.latest_amazon_linux.id  # Utilise l'AMI récupérée dans ami.tf
  instance_type = var.web_instance_type  # Type d'instance pour les serveurs WordPress

  vpc_security_group_ids = [var.web_security_group_id]  # Le Security Group pour ces instances
  subnet_id              = var.private_subnet_id  # Le sous-réseau privé où les instances seront déployées

  associate_public_ip_address = false  # Aucune adresse IP publique pour ces instances

  tags = {
    Name = "WordPress-Private-EC2-${count.index + 1}"  # Un tag pour identifier chaque instance
  }
}

# Configuration d'un groupe d'autoscaling pour les instances WordPress
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = var.web_instance_count  # Capacité désirée (le nombre d'instances à maintenir)
  max_size             = 2  # Taille maximale du groupe d'autoscaling
  min_size             = 1  # Taille minimale du groupe d'autoscaling
  vpc_zone_identifier  = [var.private_subnet_id]  # Sous-réseaux privés où les instances seront déployées
  launch_configuration = aws_launch_configuration.web_lc.id  # Configuration de lancement pour l'autoscaling

  tag {
    key                 = "Name"
    value               = "WordPress-Private-EC2-ASG"  # Tag pour les instances créées par l'ASG
    propagate_at_launch = true  # Applique ce tag à chaque instance lors de son lancement
  }
}

# Configuration de lancement utilisée par le groupe d'autoscaling = Auto Scaling Group, ASG
resource "aws_launch_configuration" "web_lc" {
  image_id        = data.aws_ami.latest_amazon_linux.id  # Utilise l'AMI récupérée dans ami.tf
  instance_type   = var.web_instance_type  # Type d'instance pour les serveurs WordPress
  security_groups = [var.web_security_group_id]  # Le Security Group pour ces instances

  lifecycle {
    create_before_destroy = true  # Assure que la nouvelle configuration est créée avant que l'ancienne ne soit détruite
  }
}
