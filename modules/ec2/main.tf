# modules/ec2/main.tf

## Création de la paire de clé
resource "aws_key_pair" "myec2key" {
  key_name   = "keypair"
  public_key = file("/home/ubuntu/project/key_rsa.pub")
}

# Instance EC2 App
resource "aws_instance" "ec2_app_a" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.app_instance_type
  subnet_id              = var.private_subnet_a_id
  vpc_security_group_ids = [aws_security_group.sg_private_wp.id]
  key_name               = aws_key_pair.myec2key.key_name
  #user_data = "${file("wp.sh")}"
  user_data = base64encode(file("${path.root}/wp.sh"))
  tags = {
    Name        = "fabien-app-a"
  }
}

# Instance EC2 App
resource "aws_instance" "ec2_app_b" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.app_instance_type
  subnet_id              = var.private_subnet_b_id
  vpc_security_group_ids = [aws_security_group.sg_private_wp.id]
  key_name               = aws_key_pair.myec2key.key_name
  user_data = base64encode(file("${path.root}/wp.sh"))
  tags = {
    Name        = "fabien-app-b"
  }
}

# # Auto Scaling Group pour gérer les instances WordPress
# resource "aws_autoscaling_group" "web_asg" {
#   launch_template {
#     id      = var.launch_template_id
#     version = "$Latest"
#   }
#   min_size             = 2
#   max_size             = 2
#   desired_capacity     = 1
#   vpc_zone_identifier  = [var.private_subnet_a_id, var.private_subnet_b_id]

#   target_group_arns    = [var.target_group_arn]
#   health_check_type    = "EC2"
#   health_check_grace_period = 300

#   tag {
#     key                 = "Name"
#     value               = "WordPress-ASG"
#     propagate_at_launch = true
#   }
# }

# Groupe Auto Scaling pour gérer les instances EC2
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  min_size = 2
  max_size = 2
  desired_capacity = 2

  vpc_zone_identifier = [var.private_subnet_a_id, var.private_subnet_b_id]

  tag {
    key                 = "Name"
    value               = "fabien-wordpress-instance"
    propagate_at_launch = true
  }

  health_check_type          = "ELB"
  health_check_grace_period = 300
  force_delete                = true
}

# Lien du groupe de mise à l'échelle automatique avec le groupe cible
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = var.target_group_arn
}