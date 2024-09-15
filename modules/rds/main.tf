# Création du groupe de sous-réseaux RDS
resource "aws_db_subnet_group" "db_subnet_group" {
  # Nom du groupe de sous-réseaux RDS
  name       = "${var.db_subnet_group}-${var.vpc_id}"

  # Liste des sous-réseaux privés
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_b_id]

  tags = {
    # Nom de la ressource
    Name = "fabien-DB-SubnetGroup"
  }
}

# Instance principale RDS MySQL
resource "aws_db_instance" "main" {
  # Taille de stockage allouée (en GB)
  allocated_storage      = 5
  # Type de stockage
  storage_type           = "gp2"
  # Moteur de base de données (MySQL)
  engine                 = "mysql"
  # Version de MySQL
  engine_version         = "8.0"
  # Type d'instance (classe)
  instance_class         = var.db_instance_class
  # Nom de la base de données
  db_name                = var.db_name
  # Nom d'utilisateur de la base de données
  username               = var.db_username
  # Mot de passe (sensible)
  password               = var.db_password
  # Groupe de paramètres MySQL
  parameter_group_name   = "default.mysql8.0"
  # Activer Multi-AZ pour la haute disponibilité
  multi_az               = var.multi_az
  # Groupe de sous-réseaux
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  # Période de rétention des backups (en jours)
  backup_retention_period = 1
  # Ne pas prendre de snapshot final à la suppression
  skip_final_snapshot     = true
  # Associer les groupes de sécurité du VPC
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    # Nom de la ressource
    Name = "fabien-RDSInstance"
  }
}

# Réplique en lecture RDS (optionnelle)
resource "aws_db_instance" "read_replica" {
  # Condition pour créer la réplique en lecture
  count                = var.create_read_replica ? 1 : 0

  # Répliquer l'instance principale
  replicate_source_db  = aws_db_instance.main.id

  # Type d'instance
  instance_class       = var.db_instance_class

  # Groupe de sous-réseaux
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  tags = {
    # Nom de la réplique
    Name = "fabien-ReadReplica-RDS"
  }
}
