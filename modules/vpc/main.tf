# modules/vpc/main.tf

# Création du VPC

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "MainVPC"
    Environment = var.environment
  }
  lifecycle {
    prevent_destroy = true  # Empêche la destruction du VPC
  }
}

# Création d'Internet Gateway (connexion entrantes et sortantes)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Main-IGW"
  }
  depends_on = [aws_vpc.main_vpc]
}

# ======= SUBNET PUBLIC A ==========================================================================
# Création du sous-réseau public A pour les serveurs

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_a
  map_public_ip_on_launch = true
  availability_zone       = var.az_a
  tags = {
    Name        = "public-a"
    Environment = var.environment
  }
}
resource "aws_route_table" "public_route_a" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public_route_b" {
  vpc_id = aws_vpc.main_vpc.id
}

# Associer le sous-réseau public-a à la table de routage
resource "aws_route_table_association" "rta_subnet_association_pub_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_a.id
}


# Créer une passerelle NAT pour le sous-réseau public A et une IP élastique
# Création de l'IP Elastic pour les NAT Gateway
resource "aws_eip" "eip_public_a" {
  # S'assurer que le NAT Gateway est supprimé d'abord
  #depends_on = [aws_nat_gateway.gw_public_a]
  domain = "vpc"
}

resource "aws_nat_gateway" "gw_public_a" {
  allocation_id = aws_eip.eip_public_a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags = {
    Name = "nat-public-a"
  }
}

# Créer une route vers la passerelle NAT
resource "aws_route" "route_app_a_nat" {
  route_table_id         = aws_route_table.rtb_app_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw_public_a.id
}

# Créer une table de routage pour le sous-réseau A
resource "aws_route_table" "rtb_app_a" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "app-a-routetable"
  }
}



# ======= SUBNET PUBLIC B ==========================================================================
# Création du sous-réseau public B pour les serveurs

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_b
  map_public_ip_on_launch = true
  availability_zone       = var.az_b
  tags = {
    Name        = "public-b"
    Environment = var.environment
  }
}

# Associer le sous-réseau public-b à la table de routage
resource "aws_route_table_association" "rta_subnet_association_pub_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_b.id
}



# Créer une passerelle NAT pour le sous-réseau public B et une IP élastique
# Création de l'IP Elastic pour les NAT Gateway
resource "aws_eip" "eip_public_b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "gw_public_b" {
  allocation_id = aws_eip.eip_public_b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  tags = {
    Name = "nat-public-b"
  }
}

# Créer une route vers la passerelle NAT
resource "aws_route" "route_app_b_nat" {
  route_table_id         = aws_route_table.rtb_app_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw_public_b.id
}

# Créer une table de routage pour le sous-réseau B
resource "aws_route_table" "rtb_app_b" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "app-b-routetable"
  }
}


# ======= TABLE DE ROUTAGE PRINCIPALE POUR LES SOUS-RÉSEAUX PUBLICS ==========================
# Création de la table de routage principale pour les sous-réseaux publics

resource "aws_route_table" "routage_public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MainPublicRouteTable"
  }
}

# ======= SUBNET PRIVÉ A ==========================================================================
# Création du sous-réseau privé A

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_a
  map_public_ip_on_launch = false
  availability_zone       = var.az_a
  tags = {
    Name        = "private-subnet-a"
    Environment = var.environment
  }
}

# ======= SUBNET PRIVÉ B ==========================================================================
# Création du sous-réseau privé B

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_b
  map_public_ip_on_launch = false
  availability_zone       = var.az_b
  tags = {
    Name        = "private-subnet-b"
    Environment = var.environment
  }
}
