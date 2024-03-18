terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.43.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
  required_version = ">= 1.3.0, < 2.0.0"
}
