# rds/main.tf

# Groupe de sous-réseaux pour RDS
resource "aws_db_subnet_group" "default" {
  name       = var.db_subnet_group
  subnet_ids = var.subnet_ids  # Les sous-réseaux doivent être dans des AZs différentes

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

# Instance principale RDS MySQL
resource "aws_db_instance" "main" {
  allocated_storage    = 5  # Taille du disque en Go
  storage_type         = "gp2"  # Type de stockage
  engine               = "mysql"  # Moteur de base de données
  engine_version       = "8.0"  # Version de MySQL
  instance_class       = var.db_instance_class  # Type d'instance
  db_name                   = var.db_name  # Nom de la base de données
  username             = var.db_username  # Nom d'utilisateur
  password             = var.db_password  # Mot de passe
  parameter_group_name = "default.mysql8.0"  # Groupe de paramètres par défaut

  multi_az             = var.multi_az  # Activer la réplication Multi-AZ pour haute disponibilité

  db_subnet_group_name = aws_db_subnet_group.default.name  # Groupe de sous-réseaux pour l'instance RDS
  vpc_security_group_ids = var.vpc_security_group_ids  # Groupes de sécurité pour l'accès RDS

  backup_retention_period = 1  # Période de rétention des sauvegardes automatiques
  skip_final_snapshot     = true  # Ne pas créer de snapshot final lors de la suppression

  tags = {
    Name = "PrimaryRDSInstance"
  }
}

# Réplique en lecture (facultatif)
resource "aws_db_instance" "read_replica" {
  count               = var.create_read_replica ? 1 : 0
  replicate_source_db = aws_db_instance.main.id  # Répliquer l'instance principale
  instance_class      = var.db_instance_class
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = "ReadReplicaRDSInstance"
  }
}
