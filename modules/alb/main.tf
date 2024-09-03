# alb/main.tf

# Création de l'application Load Balancer (ALB)
# Cette ressource crée un Load Balancer de type "application" (ALB) qui distribue le trafic HTTP et HTTPS vers les instances cibles.
# - 'name' : Nom du Load Balancer, généralement utilisé pour l'identifier dans AWS.
# - 'internal' : Définit si le Load Balancer est interne ou public (ici public).
# - 'load_balancer_type' : Spécifie que ce Load Balancer est conçu pour des applications web.
# - 'security_groups' : Liste des groupes de sécurité associés pour contrôler l'accès au Load Balancer.
# - 'subnets' : Spécifie les sous-réseaux dans lesquels le Load Balancer sera déployé, crucial pour la disponibilité.
# - 'enable_deletion_protection' : Désactive la protection contre la suppression, permettant la suppression du Load Balancer sans restrictions supplémentaires.
resource "aws_lb" "lb_app" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]
  enable_deletion_protection = false

  tags = {
    Name = var.alb_name  # Tag associé au Load Balancer pour une identification facile.
  }
}

# Création du groupe cible (Target Group) pour les instances
# Cette ressource définit un groupe cible où le Load Balancer enverra le trafic reçu.
# - 'name' : Nom du groupe cible, utilisé pour l'identifier.
# - 'port' : Port sur lequel les instances cibles recevront le trafic (ici, port 80 pour HTTP).
# - 'protocol' : Protocole de communication entre le Load Balancer et les instances (HTTP dans ce cas).
# - 'vpc_id' : ID du VPC où le groupe cible est déployé, important pour le routage du trafic dans le cloud privé.
resource "aws_lb_target_group" "app_vms" {
  name     = "tf-app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    Name = var.target_group_name  # Tag associé au groupe cible pour une identification facile.
  }
}

# Listener pour HTTP
# Ce listener écoute le trafic HTTP sur le port 80 et le redirige vers le groupe cible défini.
# - 'load_balancer_arn' : Associe le listener au Load Balancer créé.
# - 'port' : Définit le port d'écoute pour HTTP (port 80).
# - 'protocol' : Spécifie que le listener utilise le protocole HTTP.
# - 'default_action' : Indique que tout le trafic reçu doit être transféré vers le groupe cible spécifié.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb_app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_vms.arn
  }
}

# Listener pour HTTPS, si activé
# Ce listener, activé conditionnellement, écoute le trafic HTTPS sur le port 443 et le redirige vers le groupe cible.
# - 'count' : Utilisé pour activer ou désactiver le listener en fonction de la variable 'enable_https'.
# - 'load_balancer_arn' : Associe le listener au Load Balancer créé.
# - 'port' : Définit le port d'écoute pour HTTPS (port 443).
# - 'protocol' : Spécifie que le listener utilise le protocole HTTPS pour le chiffrement.
# - 'ssl_policy' : Définit la politique SSL utilisée pour sécuriser les connexions.
# - 'certificate_arn' : Spécifie l'ARN du certificat SSL nécessaire pour le chiffrement HTTPS.
resource "aws_lb_listener" "https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.lb_app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_vms.arn
  }
}

# Joindre l'instance A au groupe cible
# Cette ressource attache l'instance EC2 A au groupe cible, permettant au Load Balancer de diriger le trafic vers cette instance.
# - 'target_group_arn' : Référence le groupe cible auquel l'instance sera attachée.
# - 'target_id' : ID de l'instance EC2 A, qui recevra le trafic via le Load Balancer.
# - 'port' : Port sur lequel l'instance EC2 A écoutera le trafic (port 80).
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
  target_group_arn = aws_lb_target_group.app_vms.arn
  target_id        = var.ec2_app_a_id
  port             = 80
}

# Joindre l'instance B au groupe cible
# Cette ressource attache l'instance EC2 B au groupe cible, permettant au Load Balancer de diriger le trafic vers cette instance.
# - 'target_group_arn' : Référence le groupe cible auquel l'instance sera attachée.
# - 'target_id' : ID de l'instance EC2 B, qui recevra le trafic via le Load Balancer.
# - 'port' : Port sur lequel l'instance EC2 B écoutera le trafic (port 80).
resource "aws_lb_target_group_attachment" "tg_attachment_b" {
  target_group_arn = aws_lb_target_group.app_vms.arn
  target_id        = var.ec2_app_b_id
  port             = 80
}
