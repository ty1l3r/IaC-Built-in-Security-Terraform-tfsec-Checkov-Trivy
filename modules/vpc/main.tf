# modules/vpc/main.tf

# Création du VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr  # Plage d'adresses IP pour le VPC
  enable_dns_support   = true          # Activer le support DNS
  enable_dns_hostnames = true          # Activer les noms d'hôtes DNS
  tags = {
    Name = "MainVPC"
  }
}

# Création de la passerelle Internet (Internet Gateway)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  # Attache l'IGW au VPC

  tags = {
    Name = "MainIGW"
  }
}

# Création des sous-réseaux publics
resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidr)  # Corrigé ici
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnets_cidr, count.index)  # Corrigé ici
  availability_zone = element(var.availability_zones, count.index)  # Assigner le sous-réseau à une AZ

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

# Création des sous-réseaux privés
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)  # Corrigé ici
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets_cidr, count.index)  # Corrigé ici
  availability_zone = element(var.availability_zones, count.index)  # Assigner le sous-réseau à une AZ

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

# Création de la table de routage principale pour les sous-réseaux publics
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"  # Routage du trafic vers Internet
    gateway_id = aws_internet_gateway.igw.id  # Utiliser l'Internet Gateway pour ce routage
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Association des sous-réseaux publics à la table de routage publique
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnets_cidr)  # Corrigé ici
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Création de la NAT Gateway (dans le public subnet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id  # Associer la NAT Gateway à une IP Elastic
  subnet_id     = aws_subnet.public[0].id  # Placer la NAT Gateway dans un sous-réseau public

  tags = {
    Name = "MainNAT"
  }
}

# Création de l'IP Elastic pour la NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"  # Remplace vpc = true qui est déprécié

  tags = {
    Name = "NATElasticIP"
  }
}

# Création de la table de routage pour les sous-réseaux privés
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"  # Routage du trafic vers Internet
    nat_gateway_id = aws_nat_gateway.nat.id  # Utiliser la NAT Gateway pour ce routage
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

# Association des sous-réseaux privés à la table de routage privée
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnets_cidr)  # Corrigé ici
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
