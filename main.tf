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

resource "azurerm_resource_group" "example" {
  name     = "rg-{votre_nom}-${random_integer.nom_entier}"
  location = "West Europe"
}

resource "random_integer" "nom_entier" {
  min = 1000
  max = 9999
}

resource "azurerm_service_plan" "example" {
  name                = "asp-{votre_nom}-${random_integer.nom_entier}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "webapp-{votre_nom}-${random_integer.nom_entier}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  site_config {
    linux_fx_version = "TOMCAT|8.5-java8" # Remplacez par la version de Java et le conteneur que vous souhaitez utiliser
  }
}
