output "ieftool_settings" {
  value = yamlencode({
    "AADCommonClientID" = module.b2c.extension_app_registration_application_id
    "AADCommonObjectID" = module.b2c.extension_app_registration_object_id
    //"ApplicationInsightsInstrumentationKey": "60790e0c-86ee-4720-b2a3-32c93deadae0"
    "IdentityExperienceFrameworkAppId"      = module.b2c.identity_experience_framework_application_id
    "ProxyIdentityExperienceFrameworkAppId" = module.b2c.proxy_identity_experience_framework_application_id
    "SamlCertContainerName"                 = module.b2c.custom_certificates[0]
  })
}