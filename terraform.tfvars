# terraform.tfvars

# Plage d'adresses IP pour le VPC
vpc_cidr = "10.0.0.0/16"

# Plages d'adresses IP pour les sous-réseaux publics
public_subnets = [
  "10.0.128.0/20",  # Sous-réseau public 1
  "10.0.144.0/20"   # Sous-réseau public 2
]

# Plages d'adresses IP pour les sous-réseaux privés
private_subnets = [
  "10.0.0/19",  # Sous-réseau privé 1
  "10.0.32.0/19"   # Sous-réseau privé 2
]

# Zones de disponibilité (AZs) dans lesquelles déployer les sous-réseaux
availability_zones = [
  "eu-west-3a",  # AZ 1
  "eu-west-3b"   # AZ 2
]
