output "identity_experience_framework_application_id" {
  value = module.identity-experience-framework-app-registration.application_id
}

output "proxy_identity_experience_framework_application_id" {
  value = module.proxy-identity-experience-framework-app-registration.application_id
}

output "extension_app_registration_application_id" {
  value = data.azuread_application.extensions-app.client_id
}

output "extension_app_registration_object_id" {
  value = data.azuread_application.extensions-app.object_id
}

output "custom_app_registration_application_ids" {
  value = {
    for app in module.custom-app-registrations : app.display_name => app.application_id
  }
}

output "identity_experience_framework_encryption_key_id" {
  value = azureadb2c_trustframework_keyset_key.encryption.key_set.id
}

output "identity_experience_framework_signing_key_id" {
  value = azureadb2c_trustframework_keyset_key.signing.key_set.id
}

output "custom_certificates" {
  value = [for keyset in azureadb2c_trustframework_keyset_certificate.certificate_keysets : keyset.key_set.id]
}

output "custom_keys" {
  value = [for keyset in azureadb2c_trustframework_keyset_key.key_keysets : keyset.key_set.id]
}