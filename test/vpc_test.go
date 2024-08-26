package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestVpcModule(t *testing.T) {
    // Options de configuration de Terraform
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        // Chemin vers le module Terraform à tester
        TerraformDir: "../modules/vpc",
        
        // Variables à transmettre au module
        Vars: map[string]interface{}{
            "vpc_cidr":           "10.0.0.0/16",
            "public_subnets_cidr": []string{"10.0.128.0/20", "10.0.144.0/20"},  // Corrigé ici
            "private_subnets_cidr": []string{"10.0.0.0/19", "10.0.32.0/19"},    // Corrigé ici
            "availability_zones": []string{"eu-west-3a", "eu-west-3b"},
        },
    })

    // Nettoyage après exécution des tests
    defer terraform.Destroy(t, terraformOptions)

    // Déploie l'infrastructure
    terraform.InitAndApply(t, terraformOptions)

    // Vérifie les outputs
    vpcId := terraform.Output(t, terraformOptions, "vpc_id")
    publicSubnetIds := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
    privateSubnetIds := terraform.OutputList(t, terraformOptions, "private_subnet_ids")

    // Assertions
    assert.NotEmpty(t, vpcId)
    assert.Equal(t, 2, len(publicSubnetIds))
    assert.Equal(t, 2, len(privateSubnetIds))
}