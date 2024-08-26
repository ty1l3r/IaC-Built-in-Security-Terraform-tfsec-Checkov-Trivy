terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }

  # Décommenter cette section pour utiliser un backend distant
  # (S3 pour le stockage de l'état Terraform)
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "example-project/terraform.tfstate"
  #   region         = "eu-west-3"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}

# Configuration du provider AWS
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}