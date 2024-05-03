terraform {
  required_version = ">= 1.4.0, < 2.0.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.38.0"
    }
    azureadb2c = {
      source  = "Schumann-IT/azureadb2c"
      version = ">= 0.4.0, < 1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
    }
  }
}
