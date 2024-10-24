output "custom_app_registrations" {
  description = "Custom app registrations"
  sensitive   = true
  value = {
    for app in module.custom_app_registrations : app.display_name => {
      object_id     = app.object_id
      client_id     = app.application_id
      client_secret = app.client_secret
      redirect_uris = app.redirect_uris
    }
  }
}

output "custom_certificates" {
  description = "The ids of the custom certificates in the identity experience framework"
  value       = [for keyset in azureadb2c_trustframework_keyset_certificate.certificate_keysets : keyset.key_set.id]
}

output "custom_keys" {
  description = "The ids of the custom keys in the identity experience framework"
  value       = [for keyset in azureadb2c_trustframework_keyset_key.key_keysets : keyset.key_set.id]
}

output "extension_app_registration_application_id" {
  description = "The application id of the extension app registration"
  value       = data.azuread_application.extensions_app.client_id
}

output "extension_app_registration_object_id" {
  description = "The object id of the extension app registration"
  value       = data.azuread_application.extensions_app.object_id
}

output "identity_experience_framework_application_id" {
  description = "The application id of the identity experience framework app registration"
  value       = module.identity_experience_framework_app_registration.application_id
}

output "identity_experience_framework_encryption_key_id" {
  description = "The id of the encryption key in the identity experience framework"
  value       = azureadb2c_trustframework_keyset_key.encryption.key_set.id
}

output "identity_experience_framework_signing_key_id" {
  description = "The id of the signing key in the identity experience framework"
  value       = azureadb2c_trustframework_keyset_key.signing.key_set.id
}

output "localizations" {
  description = "The localizations"
  value       = merge(azureadb2c_organizational_branding_localization.this, azureadb2c_organizational_branding_localization.default)
}

output "proxy_identity_experience_framework_application_id" {
  description = "The application id of the proxy identity experience framework app registration"
  value       = module.proxy_identity_experience_framework_app_registration.application_id
}

output "storage_account" {
  description = "The template storage account"
  sensitive   = true
  value = {
    name               = local.storage_account.name
    primary_access_key = local.storage_account.primary_access_key
  }
}

output "storage_container_name" {
  description = "The name of the storage container"
  value       = var.template_storage.manage == true && length(data.azurerm_storage_container.template_storage) > 0 ? data.azurerm_storage_container.template_storage[0].name : azurerm_storage_container.template_storage[0].name
}
