provider "azuread" {
  tenant_id     = data.azurerm_aadb2c_directory.this.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

provider "azureadb2c" {
  tenant_id     = data.azurerm_aadb2c_directory.this.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}
