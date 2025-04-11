output "display_name" {
  value = azuread_application.this.display_name
}

output "object_id" {
  value = azuread_application.this.object_id
}

output "application_id" {
  value = azuread_application.this.client_id
}

output "client_secret" {
  value = one(azuread_application_password.this[*].value)
}

output "redirect_uris" {
  value = concat(
    tolist(try(azuread_application.this.web[0].redirect_uris, [])),
    tolist(try(azuread_application.this.public_client[0].redirect_uris, [])),
    tolist(try(azuread_application.this.single_page_application[0].redirect_uris, [])),
  )
}

output "exposed_api_permissions" {
  value = {
    (azuread_application.this.client_id) = [
      for p in azuread_application_permission_scope.this : p.scope_id
    ]
  }
}

output "admin_consent_required" {
  value = length(var.config.required_resource_access) > 0
}
