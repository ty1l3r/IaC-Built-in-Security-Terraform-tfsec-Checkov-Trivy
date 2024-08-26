module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "rds" {
  source                 = "./modules/rds"
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnets
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_subnet_group        = var.db_subnet_group  # Utilisation d'une variable globale pour éviter la dépendance circulaire
  vpc_security_group_ids = [module.vpc.default_security_group_id]  # Référence correcte au security group du VPC
}

module "ec2" {
  source                   = "./modules/ec2"
  bastion_security_group_id = var.bastion_security_group_id  # Correction de la référence à la variable
  private_subnet_id        = module.vpc.private_subnets[0]   # Sélection du premier subnet
  web_security_group_id    = var.web_security_group_id       # Correction de la référence à la variable
  public_subnet_id         = module.vpc.public_subnets[0]    # Sélection du premier subnet public
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  instance_ids   = module.ec2.instance_ids  # Assurez-vous que le module EC2 génère bien cet output
}
