# Définition du Load Balancer (ALB)
resource "aws_lb" "lb_app" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]
  enable_deletion_protection = false
  tags = {
    Name = var.alb_name
  }
}

# Groupe cible pour l'équilibreur de charge (ALB)
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
  tags = {
    Name = "fabien-lb_target_group"
  }
}

# Listener HTTP pour l'ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb_app.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_vms.arn
  }
  tags = {
    Name = "fabien-http-listener"
  }
}

# Configuration de lancement utilisée par le groupe d'autoscaling (ASG)
# Définit de quel manière laws_autoscaling_group va gérer l'initialisation.
resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-"
  image_id      = var.ami_id
  instance_type = var.web_instance_type
  key_name      = var.key_name

  user_data = base64encode(templatefile("${path.root}/wp.sh", {
  rds_endpoint = var.rds_endpoint,
  WORDPRESS_DIR = "/var/www/html"
}))


  network_interfaces {
    security_groups             = var.private_wp_sg_id
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "fabien-wordpress-instance"
    }
  }
}
