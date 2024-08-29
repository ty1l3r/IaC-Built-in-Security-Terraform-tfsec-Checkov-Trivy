module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones
}

module "rds" {
  source = "./modules/rds"

  db_instance_class     = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_subnet_group       = var.db_subnet_group # Doit provenir d'un module ou être défini comme une variable dans le root module
  vpc_security_group_ids = module.vpc.vpc_security_group_ids # Utilise l'output corrigé qui retourne une liste
  multi_az              = var.multi_az
  subnet_ids            = module.vpc.private_subnet_ids # Utilise l'output corrigé pour les sous-réseaux privés
  create_read_replica   = var.create_read_replica
  vpc_id                = module.vpc.vpc_id # Utilise l'output corrigé pour l'ID du VPC
}

module "ec2" {
  source                   = "./modules/ec2"
  bastion_security_group_id = var.bastion_security_group_id  # Utilise la variable pour le security group du bastion
  ec2_bastion_public_key_path    = var.ec2_bastion_public_key_path
  ec2_bastion_private_key_path   = var.ec2_bastion_private_key_path
  ec2_bastion_ingress_ip_1       = var.ec2_bastion_ingress_ip_1

  environment                    = var.environment
  project                        = var.project

  private_subnet_id        = module.vpc.private_subnet_ids[0] # Sélectionne le premier sous-réseau privé
  web_security_group_id    = var.web_security_group_id       # Utilise la variable pour le security group du web
  public_subnet_id         = module.vpc.public_subnet_ids[0] # Sélectionne le premier sous-réseau public
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id # Utilise l'output corrigé pour l'ID du VPC
  public_subnets = module.vpc.public_subnet_ids # Utilise l'output corrigé pour les sous-réseaux publics
  instance_ids   = module.ec2.instance_ids  # Assurez-vous que le module EC2 génère bien cet output
}
