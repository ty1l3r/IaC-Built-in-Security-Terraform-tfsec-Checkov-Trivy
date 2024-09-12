# rds/main.tf

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.db_subnet_group}-${var.vpc_id}"
     subnet_ids = [var.private_subnet_a_id, var.private_subnet_b_id]
  tags = {
    Name = "fabien-DB-SubnetGroup"
  }
}

# Instance principale RDS MySQL
resource "aws_db_instance" "main" {
  allocated_storage      = 5
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 1
  skip_final_snapshot     = true
  tags = {
    Name = "fabien-RDSInstance"
  }
}

# Réplique en lecture (facultatif)
resource "aws_db_instance" "read_replica" {
  count                 = var.create_read_replica ? 1 : 0
  replicate_source_db   = aws_db_instance.main.id  # Répliquer l'instance principale
  instance_class        = var.db_instance_class
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name
  tags = {
    Name = "fabien-ReadReplica-RDS"
  }
}
