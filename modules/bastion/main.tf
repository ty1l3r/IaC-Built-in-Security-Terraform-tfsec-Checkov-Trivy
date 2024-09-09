

## BASTION ######################################################

resource "aws_instance" "bastion" {
  count                  = 2  # Créer deux instances
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = element(var.subnet_id, count.index)  # Utilise la variable passée depuis le module root
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]
  key_name               = var.key_name

  # Cette ligne garantit que chaque instance obtient une IP publique
  associate_public_ip_address = true

  tags = {
    Name = "WT-bastion-${count.index}"  # Un nom unique pour chaque instance
  }
}


## NACL ######################################################
# Créer un NACL pour accéder à l'hôte bastion via le port 22 PORT A
resource "aws_network_acl" "public_a" {
  vpc_id = var.vpc_id
  subnet_ids = [var.public_subnet_a_id]
  tags = {
    Name        = "WT-nacl-public-a"
  }
}

# Créer un NACL pour accéder à l'hôte bastion via le port 22 PORT B
resource "aws_network_acl" "public_b" {
  vpc_id = var.vpc_id
  subnet_ids = [var.public_subnet_b_id]
  tags = {
    Name        = "WT-nacl-public-b"
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