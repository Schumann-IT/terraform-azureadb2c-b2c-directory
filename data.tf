data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_aadb2c_directory" "this" {
  resource_group_name = data.azurerm_resource_group.this.name
  domain_name         = var.domain_name
}

data "azuread_application" "extensions-app" {
  display_name = "b2c-extensions-app. Do not modify. Used by AADB2C for storing user data."
}

data "azurerm_resource_group" "template_storage" {
  count = var.template_storage.manage == true && var.template_storage.storage_account_resource_group_name == null ? 1 : 0

  name = var.template_storage.existing_storage_account_resource_group_name == null ? var.resource_group_name : var.template_storage.existing_storage_account_resource_group_name
}

data "azurerm_storage_account" "template_storage" {
  count = var.template_storage.manage == true && try(length(var.template_storage.existing_storage_account_name), 0) > 0 && length(data.azurerm_resource_group.template_storage) == 1 ? 1 : 0

  name                = var.template_storage.existing_storage_account_name
  resource_group_name = data.azurerm_resource_group.template_storage[0].name
}

data "azurerm_storage_container" "template_storage" {
  count = var.template_storage.manage == true && try(length(var.template_storage.existing_storage_container_name), 0) > 0 ? 1 : 0

  name                 = var.template_storage.existing_storage_container_name
  storage_account_name = try(data.azurerm_storage_account.template_storage[0].name, azurerm_storage_account.template_storage[0].name)
}

data "azuread_application" "b2c-extensions-app" {
  display_name = "b2c-extensions-app. Do not modify. Used by AADB2C for storing user data."
}
