module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr   
  private_subnets_cidr = var.private_subnets_cidr  
  availability_zones   = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  bastion_instance_type    = "t2.micro"
  web_instance_type        = "t2.micro"
  web_instance_count       = 2
  bastion_security_group_id = aws_security_group.bastion.id
  web_security_group_id     = aws_security_group.web.id
  public_subnet_id         = module.vpc.public_subnet_ids[0]
  private_subnet_id        = module.vpc.private_subnet_ids[0]
}

module "rds" {
  source = "./modules/rds"

  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids
  db_subnet_group        = "${var.project_name}-db-subnet-group"
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_password            = var.db_password  
}

module "alb" {
  source = "./modules/alb"

  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnet_ids
  instance_ids    = module.ec2.web_instance_ids
  alb_name        = "${var.project_name}-alb"
  target_group_name = "${var.project_name}-tg"
}