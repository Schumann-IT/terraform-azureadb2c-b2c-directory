locals {
  tenant_name = replace(var.domain_name, ".onmicrosoft.com", "")
}
