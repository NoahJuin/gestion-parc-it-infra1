terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}
 
Voici les ressources que nous allons créer dans le main.tf :
azurerm_resource_group
azurerm_service_plan
azurerm_linux_web_app
