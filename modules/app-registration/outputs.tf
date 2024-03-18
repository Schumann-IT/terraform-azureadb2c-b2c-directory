output "display_name" {
  value = azuread_application.this.display_name
}

output "object_id" {
  value = azuread_application.this.object_id
}

output "application_id" {
  value = azuread_application.this.client_id
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
