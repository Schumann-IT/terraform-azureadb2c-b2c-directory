provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = "42a361cc-97b8-446d-9f83-b617bca0ba35"
}


