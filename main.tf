terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"

  backend "azurerm" {
    resource_group_name  = "rg-noah-tfstate"
    storage_account_name = "sanoahtfstate"
    container_name       = "container-noah-tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "random_integer" "random_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-juin-noah-${random_integer.random_suffix.result}"
  location = "West Europe"
}

resource "random_integer" "asp" {
  min = 100
  max = 999
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-juin-noah-${random_integer.asp.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "random_integer" "webapp" {
  min = 100
  max = 999
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-juin-noah-${random_integer.webapp.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  service_plan_id = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      java_server        = "JAVA"
      java_version       = "java17"
      java_server_version = "17"
    }
  }
}
