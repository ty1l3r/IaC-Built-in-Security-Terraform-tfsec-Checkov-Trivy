# providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Spécifie la version du provider AWS
    }
  }
}

provider "aws" {
  alias   = "region_a"
  region  = var.az_a  # La première région AWS
}

provider "aws" {
  alias   = "region_b"
  region  = var.az_b  # La deuxième région AWS
}