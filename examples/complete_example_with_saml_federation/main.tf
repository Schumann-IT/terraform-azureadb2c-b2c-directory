terraform {
  required_version = ">= 1.4.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "b2c" {
  name = "<b2c resource group>"
}

module "b2c" {
  source                                                         = "../../"
  resource_group_name                                            = data.azurerm_resource_group.b2c.name
  client_id                                                      = "<B2C ps client app id>"
  client_secret                                                  = "<B2C ps client app secret>"
  domain_name                                                    = "example.onmicrosoft.com"
  identity_experience_framework_app_registration_object_id       = "<GUID>"
  proxy_identity_experience_framework_app_registration_object_id = "<GUID>"
  template_storage = {
    manage = true
  }

  custom_app_registrations = [
    {
      create                     = false
      app_registration_object_id = "<GUID>"
      config = {
        api = {
          requested_access_token_version = 2
        }
        web = {
          enabled       = true
          redirect_uris = ["https://localhost/"]
        }
        required_graph_api_permissions = ["e1fe6dd8-ba31-4d61-89e7-88639da4683d"] // https://learn.microsoft.com/en-us/graph/permissions-reference#userread
        identifier_uri                 = "https://example.com/issuer"
      }
      patch = {
        file              = "${path.root}/SamlApplicationPatch.json"
        saml_metadata_url = "https://example.com/broker/endpoint"
      }
  }]

  keysets = [
    {
      name                 = "SamlIdpCert"
      certificate          = "<PEM encoded Certificate>"
      certificate_password = "<Certificate passphrase>"
    },
  ]

  localizations = [
    {
      lang                  = "en-US"
      background_color      = "#ffffff",
      background_image_file = "${path.root}/backgroundimage.png",
      banner_logo_file      = "${path.root}/bannerlogo.jpg",
      sign_in_page_text     = "en-US"
      username_hint_text    = "en-US Hint"
    },
    {
      lang                  = "de-DE"
      background_color      = "#00a075",
      background_image_file = "${path.root}/backgroundimage.png",
      banner_logo_file      = "${path.root}/bannerlogo.jpg",
      sign_in_page_text     = "de-DE"
      username_hint_text    = "de-DE Hint"
    },
  ]
}
