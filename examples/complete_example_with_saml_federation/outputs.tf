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

output "localizations" {
  value = {
    for l in module.b2c.localizations : l.id => {
      square_logo_dark_url  = l.square_logo_dark_url
      square_logo_light_url = l.square_logo_light_url
      background_image_url  = l.background_image_url
      banner_logo_url       = l.banner_logo_url
      username_hint_text    = l.username_hint_text
      sign_in_page_text     = l.sign_in_page_text
    }
  }
}
