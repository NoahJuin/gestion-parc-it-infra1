terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "random_integer" "random_id" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-noah-juin-${random_integer.random_id.result}"
  location = "France Central"  # Région France Central
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-noah-juin-${random_integer.random_id.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }

  reserved = true
}

resource "azurerm_app_service" "webapp" {
  name                = "webapp-noah-juin-${random_integer.random_id.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    java_version    = "1.7"
    java_container  = "TOMCAT"
    application_stack {
        java_server = "JAVA"
        java_version = "java17"
        java_server_version = "17"
    }
  }
}
