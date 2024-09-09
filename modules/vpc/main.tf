# === Création du VPC ===
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "MainVPC-WT"
    Environment = var.environment
  }
}

# === Création de l'Internet Gateway (IGW) ===
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Main-IGW-WT"
  }
}

# === ELASTIC IP A & B =======================================================

# === Création de l'Elastic IP pour la NAT Gateway du sous-réseau public A ===
resource "aws_eip" "eip_public_a" {
  domain = "vpc"
}

# === Création de l'Elastic IP pour la NAT Gateway du sous-réseau public B ===
resource "aws_eip" "eip_public_b" {
  domain = "vpc"
}


# === SUBNETS PUBLIC A & B =======================================================

# === Sous-réseau public A ===
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_a  # Utilise la plage IP : 10.0.128.0/20
  map_public_ip_on_launch = true  # Assure l'attribution d'IP publique pour les instances
  availability_zone       = var.az_a
  tags = {
    Name        = "public-a-WT"
    Environment = var.environment
  }
}
# === Sous-réseau public B ===
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_b  # Utilise la plage IP : 10.0.144.0/20
  map_public_ip_on_launch = true  # Assure l'attribution d'IP publique pour les instances
  availability_zone       = var.az_b
  tags = {
    Name        = "WT-public-b"
    Environment = var.environment
  }
}


# === SUBNETS PRIVATE A & B =======================================================

# === Sous-réseau privé A ===
resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_a  # Utilise la plage IP : 10.0.0.0/19
  map_public_ip_on_launch = false  # Pas d'IP publique pour les sous-réseaux privés
  availability_zone       = var.az_a
  tags = {
    Name        = "WT-private-subnet-a"
    Environment = var.environment
  }
}

# === Sous-réseau privé B ===
resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_b  # Utilise la plage IP : 10.0.32.0/19
  map_public_ip_on_launch = false  # Pas d'IP publique pour les sous-réseaux privés
  availability_zone       = var.az_b
  tags = {
    Name        = "WT-private-subnet-b"
    Environment = var.environment
  }
}

# === NAT GATWAY A & B =======================================================

# === Création de la NAT Gateway public A
resource "aws_nat_gateway" "gw_public_a" {
  allocation_id = aws_eip.eip_public_a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags = {
    Name = "WT-nat-public-a"
  }
}
# === Création de la NAT Gateway  public B
resource "aws_nat_gateway" "gw_public_b" {
  allocation_id = aws_eip.eip_public_b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  tags = {
    Name = "WT-nat-public-b"
  }
}

# === ROUTES TABLES PUBLIC =======================================================

# === Table de routage pour le sous-réseau public A ===
resource "aws_route_table" "public_route_a" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"  # Route tout le trafic vers l'Internet
    gateway_id = aws_internet_gateway.igw.id  # Utilise l'IGW pour la connectivité Internet
  }
  tags = {
    Name        = "WT-public-routage-a"
  }
}

# === Table de routage pour le sous-réseau public B ===
resource "aws_route_table" "public_route_b" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Route tout le trafic vers l'Internet
    gateway_id = aws_internet_gateway.igw.id  # Utilise l'IGW pour la connectivité Internet
  }
   tags = {
    Name        = "WT-public-b"
    Environment = var.environment
  }
}

# === ROUTES TABLES PRIVE A =======================================================

# Crée une table de routage pour le sous-réseau privé A
resource "aws_route_table" "rtb_app_a" {
  vpc_id = aws_vpc.main_vpc.id  # Associe la table au VPC
  tags = {
    Name = "WT-app-a-routetable"  # Nom de la table
  }
}
# Ajoute une route pour rediriger le trafic vers la NAT Gateway
resource "aws_route" "route_private_a_nat" {
  route_table_id         = aws_route_table.rtb_app_a.id  # Spécifie la table de routage
  destination_cidr_block = "0.0.0.0/0"  # Tout le trafic sortant
  nat_gateway_id         = aws_nat_gateway.gw_public_a.id  # Redirige vers la NAT Gateway

}

# Association de la table de routage privée avec le sous-réseau privé A
resource "aws_route_table_association" "rta_subnet_association_priv_a" {
  subnet_id      = aws_subnet.private_subnet_a.id  # Sous-réseau privé A
  route_table_id = aws_route_table.rtb_app_a.id    # Table de routage privée A
}


# === ROUTES TABLES PRIVE B =======================================================

# Crée une table de routage pour le sous-réseau privé B
resource "aws_route_table" "rtb_app_b" {
  vpc_id = aws_vpc.main_vpc.id  # Associe la table au VPC
  tags = {
    Name = "WT-app-b-routetable"  # Nom de la table
  }
}

# Ajoute une route pour rediriger le trafic vers la NAT Gateway
resource "aws_route" "route_private_b_nat" {
  route_table_id         = aws_route_table.rtb_app_b.id  # Spécifie la table de routage
  destination_cidr_block = "0.0.0.0/0"  # Tout le trafic sortant
  nat_gateway_id         = aws_nat_gateway.gw_public_b.id  # Redirige vers la NAT Gateway
}

# Association de la table de routage privée avec le sous-réseau privé B
resource "aws_route_table_association" "rta_subnet_association_priv_b" {
  subnet_id      = aws_subnet.private_subnet_b.id  # Sous-réseau privé B
  route_table_id = aws_route_table.rtb_app_b.id    # Table de routage privée B
}




# === ASSOCIATION TABLE PUBLIC A & B =======================================================


# === Association de la table de routage avec le sous-réseau public A ===
resource "aws_route_table_association" "rta_subnet_association_pub_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_a.id
}

# === Association de la table de routage avec le sous-réseau public B ===
resource "aws_route_table_association" "rta_subnet_association_pub_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_b.id
}











