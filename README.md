# Terraform AWS Infrastructure - Architecture à 3 Niveaux

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Terraform Version](https://img.shields.io/badge/Terraform->=1.0.0-blueviolet)

Ce projet fournit une infrastructure AWS complète et modulaire, implémentant une architecture sécurisée à trois niveaux avec Terraform.

---

## Architecture

Une architecture robuste à trois niveaux incluant :

### Niveau Public :

* Application Load Balancer exposé à Internet
* Bastion host pour accès SSH sécurisé
* Sous-réseaux publics dans plusieurs zones de disponibilité

### Niveau Application :

* Serveurs web dans des sous-réseaux privés
* Auto-scaling pour maintenir la disponibilité et la performance
* Accès à Internet sortant via NAT Gateway

### Niveau Données :

* Base de données RDS MySQL/PostgreSQL dans sous-réseaux privés
* Option Multi-AZ pour la haute disponibilité
* Réplique en lecture optionnelle

---

## Fonctionnalités

* Infrastructure complète prête à l'emploi
* Architecture modulaire pour une maintenance facilitée
* Multi-AZ pour une haute disponibilité
* Sécurité renforcée avec séparation des couches réseau
* Pipeline CI/CD avec GitHub Actions
* Tests automatisés avec Terratest

---

## Prérequis

* Terraform v1.0.0+
* AWS CLI configuré avec les droits appropriés
* Go 1.18+ (pour Terratest)

---

## Structure du projet

```
terraform-exemple/
├── modules/                 # Modules réutilisables
│   ├── vpc/                 # Réseau et connectivité
│   ├── ec2/                 # Instances et auto-scaling
│   ├── rds/                 # Base de données
│   └── alb/                 # Application Load Balancer
├── .github/workflows/       # Pipeline CI/CD
├── test/                    # Tests Terratest
├── main.tf                  # Configuration principale
├── variables.tf             # Définition des variables
├── outputs.tf               # Sorties
├── providers.tf             # Configuration des providers
└── security_groups.tf       # Groupes de sécurité
```

---

## Guide d'utilisation

### Installation

```bash
# Clone du repo
git clone https://github.com/username/terraform-exemple.git
cd terraform-exemple

# Préparation de la configuration
cp terraform.tfvars.example terraform.tfvars
```

### Configuration

Éditez le fichier `terraform.tfvars` avec vos valeurs :

```hcl
aws_region         = "eu-west-3"
project_name       = "my-project"
environment        = "dev"
vpc_cidr           = "10.0.0.0/16"
public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones = ["eu-west-3a", "eu-west-3b"]
```

> N'incluez jamais des mots de passe en clair dans les fichiers versionnés

---

### Déploiement

```bash
# Initialisation de Terraform
terraform init

# Vérification du plan d'exécution
terraform plan

# Déploiement de l'infrastructure
terraform apply

# Suppression de toutes les ressources
terraform destroy
```

---

## Considérations de sécurité

* Trafic segmenté par niveaux
* SSH accessible uniquement via le bastion host
* Base de données accessible uniquement depuis les serveurs applicatifs
* Groupes de sécurité restrictifs pour chaque composant
* Analyse de sécurité automatisée dans le pipeline CI/CD

---

## Modules

### Module VPC

* VPC avec plage CIDR personnalisable
* Sous-réseaux publics et privés
* Internet Gateway et NAT Gateway
* Tables de routage

### Module EC2

* Instance bastion dans sous-réseau public
* Serveurs web dans sous-réseaux privés
* Groupe d'auto-scaling
* Configuration de démarrage

### Module RDS

* Instance RDS MySQL/PostgreSQL
* Option Multi-AZ
* Groupe de sous-réseaux dédié
* Réplique en lecture optionnelle

### Module ALB

* Application Load Balancer
* Target groups
* Health checks
* Support HTTP/HTTPS

---

## Variables principales

| Nom                    | Description                 | Type         | Défaut                            |
| ---------------------- | --------------------------- | ------------ | --------------------------------- |
| aws\_region            | Région AWS                  | string       | "eu-west-3"                       |
| project\_name          | Nom du projet               | string       | "example-project"                 |
| environment            | Environnement               | string       | "dev"                             |
| vpc\_cidr              | CIDR du VPC                 | string       | "10.0.0.0/16"                     |
| public\_subnets\_cidr  | CIDRs sous-réseaux publics  | list(string) | \["10.0.1.0/24", "10.0.2.0/24"]   |
| private\_subnets\_cidr | CIDRs sous-réseaux privés   | list(string) | \["10.0.10.0/24", "10.0.11.0/24"] |
| db\_password           | Mot de passe BDD (sensible) | string       | requis                            |

---

## Outputs

| Nom                  | Description                  |
| -------------------- | ---------------------------- |
| vpc\_id              | ID du VPC                    |
| public\_subnet\_ids  | IDs des sous-réseaux publics |
| private\_subnet\_ids | IDs des sous-réseaux privés  |
| bastion\_public\_ip  | IP publique du bastion       |
| alb\_dns\_name       | Nom DNS du load balancer     |

---

## Tests

```bash
cd test
go mod tidy
go test -v ./...
```

---

## CI/CD

Le workflow GitHub Actions inclut :

* Validation du code Terraform
* Analyse de sécurité avec tfsec, Checkov et Trivy
* Tests d'infrastructure avec Terratest
* Publication du plan Terraform dans les PRs

---

## Contribution

1. Fork le projet
2. Créer une branche : `git checkout -b feature/amazing-feature`
3. Commit : `git commit -m 'Add amazing feature'`
4. Push : `git push origin feature/amazing-feature`
5. Ouvrir une Pull Request

---

## Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

---

## Avertissement

Ce projet est un exemple d'architecture et **ne doit pas être utilisé en production** sans une évaluation approfondie de sécurité et de performance.
