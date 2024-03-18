# terraform-azureadb2c-directory

This module manages the configuration of an Azure AD B2C directory.

**Features:**
- Create app registrations according to [docs](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-custom-policy)
- Create policy keys according to [docs](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-custom-policy)
- Create custom apps (e.g. [saml](https://learn.microsoft.com/en-us/azure/active-directory-b2c/saml-service-provider?tabs=macos&pivots=b2c-custom-policy))
- Create custom policy keys (e.g. [saml certificate](https://learn.microsoft.com/en-us/azure/active-directory-b2c/saml-service-provider?tabs=macos&pivots=b2c-custom-policy#set-up-certificates))

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.43.0 |
| <a name="requirement_azureadb2c"></a> [azureadb2c](#requirement\_azureadb2c) | 0.2.2-pre |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >=2.43.0 |
| <a name="provider_azureadb2c"></a> [azureadb2c](#provider\_azureadb2c) | 0.2.2-pre |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom-app-registrations"></a> [custom-app-registrations](#module\_custom-app-registrations) | ./modules/app-registration | n/a |
| <a name="module_identity-experience-framework-app-registration"></a> [identity-experience-framework-app-registration](#module\_identity-experience-framework-app-registration) | ./modules/app-registration | n/a |
| <a name="module_proxy-identity-experience-framework-app-registration"></a> [proxy-identity-experience-framework-app-registration](#module\_proxy-identity-experience-framework-app-registration) | ./modules/app-registration | n/a |

## Resources

| Name | Type |
|------|------|
| [azureadb2c_application_patch.custom_app_registrations](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/application_patch) | resource |
| [azureadb2c_application_patch.identity-experience-framework-app-registration](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/application_patch) | resource |
| [azureadb2c_trustframework_keyset_certificate.certificate_keysets](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/trustframework_keyset_certificate) | resource |
| [azureadb2c_trustframework_keyset_key.encryption](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/trustframework_keyset_key) | resource |
| [azureadb2c_trustframework_keyset_key.key_keysets](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/trustframework_keyset_key) | resource |
| [azureadb2c_trustframework_keyset_key.signing](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/0.2.2-pre/docs/resources/trustframework_keyset_key) | resource |
| [azurerm_resource_group.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azuread_application.b2c-extensions-app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_application.extensions-app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azurerm_aadb2c_directory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/aadb2c_directory) | data source |
| [azurerm_resource_group.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The Client ID which should be used when authenticating as a service principal. | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | The application password to be used when authenticating using a client secret. | `string` | n/a | yes |
| <a name="input_custom_app_registrations"></a> [custom\_app\_registrations](#input\_custom\_app\_registrations) | n/a | <pre>list(object({<br>    create                     = optional(bool, false)<br>    app_registration_object_id = optional(string, null)<br>    config = object({<br>      display_name                   = optional(string, null)<br>      fallback_public_client_enabled = optional(bool, false)<br>      api = object({<br>        known_client_applications      = optional(list(string), [])<br>        mapped_claims_enabled          = optional(bool, false)<br>        requested_access_token_version = number<br>      })<br>      web = optional(object({<br>        enabled                       = optional(bool, false)<br>        redirect_uris                 = optional(list(string), [])<br>        logout_url                    = optional(string, null)<br>        access_token_issuance_enabled = optional(bool, false)<br>        id_token_issuance_enabled     = optional(bool, false)<br>      }), {})<br>      public_client = optional(object({<br>        enabled       = optional(bool, false)<br>        redirect_uris = optional(list(string), [])<br>      }), {})<br>      required_graph_api_permissions = optional(list(string), [])<br>      identifier_uri                 = optional(string, "")<br>      domain_name                    = optional(string, "")<br>      permission_scopes = optional(list(object({<br>        name                       = string<br>        consent_type               = optional(string, "Admin")<br>        admin_consent_description  = string<br>        admin_consent_display_name = string<br>      })), [])<br>      required_resource_access = optional(map(list(string)), {})<br>    })<br>    patch = optional(object({<br>      file              = string<br>      saml_metadata_url = optional(string, null)<br>    }), null)<br>  }))</pre> | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the b2c directory domain | `string` | n/a | yes |
| <a name="input_identity_experience_framework_app_registration_object_id"></a> [identity\_experience\_framework\_app\_registration\_object\_id](#input\_identity\_experience\_framework\_app\_registration\_object\_id) | The object ID of the app registration for the identity experience framework | `string` | n/a | yes |
| <a name="input_keysets"></a> [keysets](#input\_keysets) | n/a | <pre>list(object({<br>    name                 = string<br>    use                  = optional(string, null)<br>    type                 = optional(string, null)<br>    certificate          = optional(string, null)<br>    certificate_password = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_proxy_identity_experience_framework_app_registration_object_id"></a> [proxy\_identity\_experience\_framework\_app\_registration\_object\_id](#input\_proxy\_identity\_experience\_framework\_app\_registration\_object\_id) | The object ID of the app registration for the proxy identity experience framework | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the b2c directory has been created | `string` | n/a | yes |
| <a name="input_template_storage"></a> [template\_storage](#input\_template\_storage) | n/a | <pre>object({<br>    manage                                       = bool<br>    existing_storage_account_name                = optional(string, null)<br>    existing_storage_account_resource_group_name = optional(string, null)<br>    existing_storage_container_name              = optional(string, null)<br>    storage_account_name                         = optional(string, null)<br>    storage_account_resource_group_name          = optional(string, null)<br>    storage_account_location                     = optional(string, null)<br>    storage_container_name                       = optional(string, null)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_app_registration_application_ids"></a> [custom\_app\_registration\_application\_ids](#output\_custom\_app\_registration\_application\_ids) | n/a |
| <a name="output_custom_certificates"></a> [custom\_certificates](#output\_custom\_certificates) | n/a |
| <a name="output_custom_keys"></a> [custom\_keys](#output\_custom\_keys) | n/a |
| <a name="output_extension_app_registration_application_id"></a> [extension\_app\_registration\_application\_id](#output\_extension\_app\_registration\_application\_id) | n/a |
| <a name="output_extension_app_registration_object_id"></a> [extension\_app\_registration\_object\_id](#output\_extension\_app\_registration\_object\_id) | n/a |
| <a name="output_identity_experience_framework_application_id"></a> [identity\_experience\_framework\_application\_id](#output\_identity\_experience\_framework\_application\_id) | n/a |
| <a name="output_identity_experience_framework_encryption_key_id"></a> [identity\_experience\_framework\_encryption\_key\_id](#output\_identity\_experience\_framework\_encryption\_key\_id) | n/a |
| <a name="output_identity_experience_framework_signing_key_id"></a> [identity\_experience\_framework\_signing\_key\_id](#output\_identity\_experience\_framework\_signing\_key\_id) | n/a |
| <a name="output_proxy_identity_experience_framework_application_id"></a> [proxy\_identity\_experience\_framework\_application\_id](#output\_proxy\_identity\_experience\_framework\_application\_id) | n/a |
<!-- END_TF_DOCS -->
