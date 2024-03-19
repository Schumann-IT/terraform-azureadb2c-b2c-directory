terraform {
  required_version = ">= 1.7"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.43.0"
    }
    azureadb2c = {
      source  = "Schumann-IT/azureadb2c"
      version = ">= 0.2.1, < 1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
    }
  }
}
