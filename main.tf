module "identity_experience_framework_app_registration" {
  source = "./modules/app-registration"

  create    = false
  object_id = var.identity_experience_framework_app_registration_object_id

  config = {
    domain_name = data.azurerm_aadb2c_directory.this.domain_name
    api = {
      requested_access_token_version = null
    }
    web = {
      enabled = true
      redirect_uris = [
        format("https://%s.b2clogin.com/%s", local.tenant_name, var.domain_name)
      ]
    }
    required_graph_api_permissions = [
      "37f7f235-527c-4136-accd-4a02d197296e", # https://learn.microsoft.com/en-us/graph/permissions-reference#openid
      "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"  # https://learn.microsoft.com/en-us/graph/permissions-reference#offline_access
    ]
    permission_scopes = [
      {
        name                       = "user_impersonation"
        admin_consent_description  = "Allow the application to access IdentityExperienceFramework on behalf of the signed-in user."
        admin_consent_display_name = "Access IdentityExperienceFramework"
      }
    ]
  }
}

resource "azureadb2c_application_patch" "identity_experience_framework_app_registration" {
  object_id  = module.identity_experience_framework_app_registration.object_id
  patch_file = "${path.module}/IdentityExperienceFrameworkAppPatch.json"
}

module "proxy_identity_experience_framework_app_registration" {
  source = "./modules/app-registration"

  create    = false
  object_id = var.proxy_identity_experience_framework_app_registration_object_id

  config = {
    fallback_public_client_enabled = true
    api = {
      requested_access_token_version = 2
    }
    public_client = {
      enabled = true
      redirect_uris = [
        "myapp://auth"
      ]
    }
    required_graph_api_permissions = [
      "37f7f235-527c-4136-accd-4a02d197296e", # https://learn.microsoft.com/en-us/graph/permissions-reference#openid
      "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"  # https://learn.microsoft.com/en-us/graph/permissions-reference#offline_access
    ]
    required_resource_access = module.identity_experience_framework_app_registration.exposed_api_permissions
  }
}

module "custom_app_registrations" {
  source = "./modules/app-registration"

  for_each = {
    for app in var.custom_app_registrations : app.create == false ? data.azuread_application.existing_custom_app_registrations[app.app_registration_object_id].display_name : app.config.display_name => app
  }

  create    = each.value.create
  object_id = each.value.app_registration_object_id
  config    = each.value.config
}

resource "azureadb2c_application_patch" "custom_app_registrations" {
  for_each = {
    for app in var.custom_app_registrations : app.create == false ? data.azuread_application.existing_custom_app_registrations[app.app_registration_object_id].display_name : app.config.display_name => app if try(app.patch, null) != null
  }
  object_id         = module.custom_app_registrations[each.key].object_id
  patch_file        = each.value.patch.file
  saml_metadata_url = try(each.value.patch.saml_metadata_url, null)
}


resource "azurerm_resource_group" "template_storage" {
  count = var.template_storage.manage == true && length(data.azurerm_resource_group.template_storage) > 0 ? 0 : 1

  location = try(var.template_storage.storage_account_location, data.azurerm_resource_group.this.location)
  name     = try(var.template_storage.storage_account_resource_group_name, data.azurerm_resource_group.this.name)
  tags     = {}
}

resource "azurerm_storage_account" "template_storage" {
  count = var.template_storage.manage == true && length(data.azurerm_storage_account.template_storage) > 0 ? 0 : 1

  account_replication_type = "GRS"
  account_tier             = "Standard"
  location                 = try(data.azurerm_resource_group.template_storage[0].location, azurerm_resource_group.template_storage[0].location)
  name                     = var.template_storage.storage_account_name == null ? local.tenant_name : var.template_storage.storage_account_name
  resource_group_name      = try(data.azurerm_resource_group.template_storage[0].name, azurerm_resource_group.template_storage[0].name)
  tags                     = {}

  blob_properties {
    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "OPTIONS"]
      allowed_origins    = [format("https://%s.b2clogin.com", local.tenant_name)]
      exposed_headers    = ["*"]
      max_age_in_seconds = 200
    }
  }
}

resource "azurerm_storage_container" "template_storage" {
  count = var.template_storage.manage == true && length(data.azurerm_storage_container.template_storage) > 0 ? 0 : 1

  name                  = var.template_storage.storage_container_name == null ? "trustframeworktemplates" : var.template_storage.storage_container_name
  storage_account_name  = try(data.azurerm_storage_account.template_storage[0].name, azurerm_storage_account.template_storage[0].name)
  container_access_type = "blob"
}

resource "azureadb2c_trustframework_keyset_key" "signing" {
  key_set = {
    name = "TokenSigningKeyContainer"
  }

  use  = "sig"
  type = "RSA"
}

resource "azureadb2c_trustframework_keyset_key" "encryption" {
  key_set = {
    name = "TokenEncryptionKeyContainer"
  }

  use  = "enc"
  type = "RSA"
}

resource "azureadb2c_trustframework_keyset_certificate" "certificate_keysets" {
  for_each = {
    for keyset in var.keysets : keyset.name => keyset if keyset.certificate != null
  }

  key_set = {
    name = each.key
  }

  certificate = each.value.certificate
  password    = each.value.certificate_password
}

resource "azureadb2c_trustframework_keyset_key" "key_keysets" {
  for_each = {
    for keyset in var.keysets : keyset.name => keyset if keyset.use != null
  }

  key_set = {
    name = each.key
  }

  use  = each.value.use
  type = each.value.type
}