# rds/security_groups.tf

# Création d'un groupe de sécurité pour l'instance RDS MySQL
resource "aws_security_group" "rds" {
  name        = "rds_security_group"  # Nom du groupe de sécurité
  description = "Security group for RDS instance"  # Description pour identifier l'usage du groupe de sécurité
  vpc_id      = var.vpc_id  # ID du VPC dans lequel ce groupe de sécurité sera créé

  # Configuration de la règle d'entrée (ingress)
  ingress {
    from_port   = 3306  # Port de début pour la règle d'entrée, 3306 est le port par défaut de MySQL
    to_port     = 3306  # Port de fin pour la règle d'entrée, ici on autorise uniquement le port 3306
    protocol    = "tcp"  # Protocole utilisé, ici TCP car MySQL fonctionne sur TCP
    cidr_blocks = ["10.0.0.0/16"]  # Autorise le trafic entrant depuis l'ensemble du VPC (plage d'adresses IP)
  }

  # Configuration de la règle de sortie (egress)
  egress {
    from_port   = 0  # Port de début pour la règle de sortie, 0 indique qu'on autorise tous les ports
    to_port     = 0  # Port de fin pour la règle de sortie, 0 signifie tous les ports
    protocol    = "-1"  # "-1" signifie que tous les protocoles sont autorisés (TCP, UDP, ICMP, etc.)
    cidr_blocks = ["0.0.0.0/0"]  # Autorise le trafic sortant vers n'importe quelle adresse IP (Internet)
  }

  # Tags pour identifier et gérer le groupe de sécurité
  tags = {
    Name = "RDSSecurityGroup"  # Nom donné au groupe de sécurité pour l'identifier dans la console AWS
  }
}
