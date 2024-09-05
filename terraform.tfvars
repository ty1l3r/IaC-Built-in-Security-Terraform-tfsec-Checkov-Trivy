# terraform.tfvars

/*
public_subnets = ["10.0.128.0/20", "10.0.144.0/20"]
private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
db_name = "wordpressdb"
db_username = "admin"
db_password = "admin"
ec2_bastion_public_key_path = "${path.root}/secrets/ec2-bastion-key-pair.pub"
ec2_bastion_private_key_path = "${path.root}/secrets/ec2-bastion-key-pair.pem"
ec2_bastion_ingress_ip_1     = "0.0.0.0/0"
*/



# Valeurs pour les variables de l'environnement et du projet
environment = "dev"
project     = "KANGOUROUXXXXZZZ"

db_name = "wordpressdb"
db_username = "admin"
db_password = "admin"

