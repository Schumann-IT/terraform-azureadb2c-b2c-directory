locals {
  tenant_name = replace(var.domain_name, ".onmicrosoft.com", "")

  storage_account = var.template_storage.manage == true && length(data.azurerm_storage_account.template_storage) > 0 ? data.azurerm_storage_account.template_storage[0] : azurerm_storage_account.template_storage[0]
}
