# main.tf root
module "ami" {
  source = "./modules/ami"
}

module "bastion" {
  source                = "./modules/bastion"
  vpc_id                = module.vpc.vpc_id
  public_subnet_a_id    = module.vpc.public_subnet_a_id
  public_subnet_b_id    = module.vpc.public_subnet_b_id
  key_name              = module.ec2.key_name
}


# Module VPC : Crée le VPC, les sous-réseaux publics/privés, et les security groups de base
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  cidr_public_subnet_a  = var.cidr_public_subnet_a   #var.cidr_public_subnet_a
  cidr_public_subnet_b  = var.cidr_public_subnet_b  #var.cidr_public_subnet_b
  cidr_private_subnet_a = var.cidr_private_subnet_a
  cidr_private_subnet_b = var.cidr_private_subnet_b #var.cidr_private_subnet_b
  az_a                  = var.az_a
  az_b                  = var.az_b
}

# Module RDS : Crée la base de données RDS, en utilisant les sous-réseaux privés pour la haute disponibilité
module "rds" {
  source                 = "./modules/rds"
  db_instance_class      = var.db_instance_class
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_subnet_group        = var.db_subnet_group
  rds_security_group_id  = [module.rds.rds_security_group_id]
  multi_az               = var.multi_az
  subnet_ids             = [module.rds.subnet_ids]
  create_read_replica    = var.create_read_replica
  vpc_id                 = module.vpc.vpc_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
}

# Module EC2 : Déploie les instances EC2 pour le Bastion Host et les serveurs WordPress
module "ec2" {
  source                    = "./modules/ec2"
  vpc_id                    = module.vpc.vpc_id
  environment               = var.environment
  project                   = var.project
  private_subnet_a_id       = module.vpc.private_subnet_a_id
  private_subnet_b_id       = module.vpc.private_subnet_b_id
  web_instance_type         = var.web_instance_type
  private_wp_sg_id          = module.ec2.private_wp_sg_id
  bastion_sg_id             = [module.bastion.bastion_sg_id]
  launch_template_id        = module.alb.wordpress_launch_template_id
  target_group_arn          = module.alb.target_group_arn
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  public_subnet_a_id  = module.vpc.public_subnet_a_id
  public_subnet_b_id  = module.vpc.public_subnet_b_id
  alb_name            = var.alb_name
  ec2_app_a_id        = module.ec2.ec2_app_a_id
  ec2_app_b_id        = module.ec2.ec2_app_b_id
  ami_id              = module.ami.ami_id
  key_name            = module.ec2.key_name
  private_wp_sg_id    = [module.ec2.private_wp_sg_id]
}

