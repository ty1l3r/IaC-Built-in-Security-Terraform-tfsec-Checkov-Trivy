# Définition du Load Balancer (ALB) : Crée un Application Load Balancer externe avec des sous-réseaux publics
resource "aws_lb" "lb_app" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]
  enable_deletion_protection = false

  # Balancer étiqueté avec son nom
  tags = {
    Name = var.alb_name
  }
}

# Groupe cible pour l'équilibreur de charge (ALB) : Définit le groupe cible pour les instances EC2
resource "aws_lb_target_group" "app_vms" {
  name     = "fabien-web-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # Configuration du Health Check pour vérifier la santé des backends
  health_check {
    protocol            = "HTTP"
    path                = "/healthcheck.html"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  # Étiquette du groupe cible
  tags = {
    Name = "fabien-lb_target_group"
  }
}

# Listener HTTP pour l'ALB : Permet de rediriger le trafic HTTP vers le groupe cible
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb_app.arn
  port              = 80
  protocol          = "HTTP"

  # Redirige les requêtes vers le groupe cible
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_vms.arn
  }

  # Étiquette du listener
  tags = {
    Name = "fabien-http-listener"
  }
}

# Configuration de lancement pour ASG : Définit les paramètres de lancement des instances EC2 pour WordPress
resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-"
  image_id      = var.ami_id
  instance_type = var.web_instance_type
  key_name      = var.key_name

  # Script de démarrage pour initialiser WordPress avec l'accès RDS
  user_data = base64encode(templatefile("${path.root}/wp.sh", {
    rds_endpoint = var.rds_endpoint,
    db_username  = var.db_username,
    db_password = var.db_password

    WORDPRESS_DIR = "/var/www/html"
  }))

  # Configuration réseau avec les security groups pour les instances privées WordPress
  network_interfaces {
    security_groups = var.private_wp_sg_id
  }

  # Définition de l'espace disque pour l'instance
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
    }
  }

  # Étiquette pour les instances créées par le groupe de lancement
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "fabien-wordpress-instance"
    }
  }
}
