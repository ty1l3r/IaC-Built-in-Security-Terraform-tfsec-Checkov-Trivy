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
  db_subnet_group       = module.vpc.db_subnet_group_name  # Notez que cela doit provenir d'un module ou être défini comme une variable dans le root module
  vpc_security_group_ids = module.vpc.security_group_ids
  multi_az              = var.multi_az
  subnet_ids            = module.vpc.private_subnet_ids
  create_read_replica   = var.create_read_replica
  vpc_id                = module.vpc.vpc_id
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
