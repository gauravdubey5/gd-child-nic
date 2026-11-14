terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "nic" {
  source = "../../"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_configurations   = var.ip_configurations
  tags                = var.tags
}
