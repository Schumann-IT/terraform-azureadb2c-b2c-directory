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
  name = "b2c"
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
        sign_in_audience = "AzureADandPersonalMicrosoftAccount"
        api = {
          requested_access_token_version = 2
        }
        web = {
          enabled       = true
          redirect_uris = ["http://localhost:8080/"]
        }
        public_client = {
          enabled = false
        }
        required_graph_api_permissions = [
          "37f7f235-527c-4136-accd-4a02d197296e", # https://learn.microsoft.com/en-us/graph/permissions-reference#openid
          "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"  # https://learn.microsoft.com/en-us/graph/permissions-reference#offline_access
        ]
        domain_name = "example.onmicrosoft.com"
      }
  }]
}
