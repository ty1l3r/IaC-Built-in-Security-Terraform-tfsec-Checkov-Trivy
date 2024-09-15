## Création de la paire de clé pour les instances EC2
resource "aws_key_pair" "myec2key" {
  key_name   = "keypair"
  public_key = file("/home/ubuntu/project/key_rsa.pub")
}

# Groupe Auto Scaling pour gérer les instances EC2
# Configure le groupe Auto Scaling avec un template de lancement et définit la taille minimale et maximale des instances.
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  # Taille minimale, maximale et désirée des instances EC2
  min_size         = 2
  max_size         = 2
  desired_capacity = 2

  # Identifier les sous-réseaux privés dans lesquels déployer les instances EC2
  vpc_zone_identifier = [var.private_subnet_a_id, var.private_subnet_b_id]

  # Ajouter un tag pour les instances EC2
  tag {
    key                 = "Name"
    value               = "fabien-wordpress-instances"
    propagate_at_launch = true
  }

  # Vérification de la santé basée sur l'ELB avec une période de grâce
  health_check_type          = "ELB"
  health_check_grace_period  = 300

  # Suppression forcée du groupe lors de la suppression de la ressource
  force_delete               = true
}

# Lien du groupe Auto Scaling avec le groupe cible ALB
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = var.target_group_arn
}
