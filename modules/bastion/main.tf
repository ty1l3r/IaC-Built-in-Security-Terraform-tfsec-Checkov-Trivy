## Création de la paire de clé du serveur  Bastion

resource "aws_key_pair" "myec2key" {
  key_name   = "keypair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

## BASTION ######################################################

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.latest_amazon_linux
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_a_id
  vpc_security_group_ids = [aws_security_group.sg_bastion]
  key_name               = aws_key_pair.myec2key.key_name
    tags = {
      Name        = "bastion"
    }
  }

## NACL ######################################################

# Créer un NACL pour accéder à l'hôte bastion via le port 22 PORT A
resource "aws_network_acl" "public_a" {
  vpc_id = var.vpc_id
  subnet_ids = [aws_subnet.public_subnet_a.id]
  tags = {
    Name        = "nacl-public-a"
  }
}

# Créer un NACL pour accéder à l'hôte bastion via le port 22 PORT B
resource "aws_network_acl" "public_b" {
  vpc_id = var.vpc_id
  subnet_ids = [aws_subnet.public_subnet_b.id]
  tags = {
    Name        = "nacl-public-b"
  }
}

resource "aws_network_acl_rule" "nat_inbound" {
  network_acl_id = aws_network_acl.public_a.id
  rule_number    = 200
  egress         = false
  protocol       = "-1" #Tous les protocles (TCP/UDP...)
  rule_action    = "allow"
  # L'ouverture à 0.0.0.0/0 peut entraîner des failles de sécurité. vous devez restreindre uniquement l'acces à votre ip publique
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}

resource "aws_network_acl_rule" "nat_inboundb" {
  network_acl_id = aws_network_acl.public_b.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  # L'ouverture à 0.0.0.0/0 peut entraîner des failles de sécurité. vous devez restreindre uniquement l'acces à votre ip publique
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}