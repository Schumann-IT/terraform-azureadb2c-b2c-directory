# import statements to import exsisting app registrations

#import {
#  id = "/applications/<object-id of the proxy app>"
#  to = module.b2c.module.proxy_identity_experience_framework_app_registration.azuread_application.this
#}
#
#import {
#  id = "/applications/<object-id of the identity experiance app>"
#  to = module.b2c.module.identity_experience_framework_app_registration.azuread_application.this
#}
#
#import {
#  id = "/applications/<object-id of the saml app>"
#  to = module.b2c.module.custom_app_registrations["<object-id of the saml app>"].azuread_application.this
#}

data "azurerm_resource_group" "this" {
  name = "b2c"
}

module "b2c" {
  source                                                         = "../../"
  resource_group_name                                            = data.azurerm_resource_group.this.name
  client_id                                                      = "<the service principal client id"
  client_secret                                                  = "<the service principal client secret (password)"
  domain_name                                                    = "<the directory domain name>"
  identity_experience_framework_app_registration_object_id       = "<object-id of the identity experiance app>"
  proxy_identity_experience_framework_app_registration_object_id = "<object-id of the proxy app>"
  template_storage = {
    manage = true
  }

  custom_app_registrations = [
    {
      create                     = false
      app_registration_object_id = "<object-id of the saml app>"
      config = {
        fallback_public_client_enabled = false
        api = {
          known_client_applications      = []
          mapped_claims_enabled          = false
          requested_access_token_version = 2
        }
        web = {
          enabled                       = true
          redirect_uris                 = ["https://localhost/"]
          logout_url                    = null
          access_token_issuance_enabled = false
          id_token_issuance_enabled     = false
        }
        public_client = {
          enabled       = false
          redirect_uris = []
        }
        required_graph_api_permissions = ["e1fe6dd8-ba31-4d61-89e7-88639da4683d"]
        identifier_uri                 = "<the identifier uri"
        domain_name                    = "<the b2c directory domain name>"
        permission_scopes              = []
        required_resource_access       = {}
      }
      patch = {
        file              = "${path.root}/SamlApplicationPatch.json"
        saml_metadata_url = "<the saml metadata url"
      }
  }]

  keysets = [
    {
      name                 = "SamlIdpCert"
      certificate          = "<the pkcs12 certificate base64 encoded>"
      certificate_password = "<the sertificate passphrase>"
    },
  ]
}