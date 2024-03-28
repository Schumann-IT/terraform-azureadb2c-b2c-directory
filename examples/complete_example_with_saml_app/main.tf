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
  name = var.resource_group_name
}

module "b2c" {
  source                                                         = "../../"
  resource_group_name                                            = data.azurerm_resource_group.b2c.name
  client_id                                                      = var.client_id
  client_secret                                                  = var.client_secret
  domain_name                                                    = var.domain_name
  identity_experience_framework_app_registration_object_id       = var.identity_experience_framework_app_registration_object_id
  proxy_identity_experience_framework_app_registration_object_id = var.proxy_identity_experience_framework_app_registration_object_id
  template_storage = {
    manage = true
  }

  custom_app_registrations = [
    {
      create                     = false
      app_registration_object_id = var.saml_app_registration_object_id
      config = {
        api = {
          requested_access_token_version = 2
        }
        web = {
          enabled       = true
          redirect_uris = ["https://localhost/"]
        }
        required_graph_api_permissions = ["e1fe6dd8-ba31-4d61-89e7-88639da4683d"]
        identifier_uri                 = var.saml_identifier_uri
      }
      patch = {
        file              = "${path.root}/SamlApplicationPatch.json"
        saml_metadata_url = var.saml_metadata_url
      }
  }]

  keysets = [
    {
      name                 = "SamlIdpCert"
      certificate          = var.saml_certificate
      certificate_password = var.saml_certificate_password
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

