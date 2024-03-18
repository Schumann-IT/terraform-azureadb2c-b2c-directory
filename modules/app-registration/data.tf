data "azuread_application" "this" {
  count     = var.create ? 0 : 1
  object_id = var.object_id
}
