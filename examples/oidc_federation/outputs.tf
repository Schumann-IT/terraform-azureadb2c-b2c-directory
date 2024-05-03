output "azure_b2c_cli_settings" {
  value = yamlencode({
    AADCommonClientID                     = module.b2c.extension_app_registration_application_id
    AADCommonObjectID                     = module.b2c.extension_app_registration_object_id
    IdentityExperienceFrameworkAppId      = module.b2c.identity_experience_framework_application_id
    ProxyIdentityExperienceFrameworkAppId = module.b2c.proxy_identity_experience_framework_application_id
    SamlCertContainerID                   = module.b2c.custom_certificates[0]
    TokenEncryptionKeyContainerID         = module.b2c.identity_experience_framework_encryption_key_id
    TokenSigningKeyContainerID            = module.b2c.identity_experience_framework_signing_key_id
  })
}
