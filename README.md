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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0, < 2.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.38.0 |
| <a name="requirement_azureadb2c"></a> [azureadb2c](#requirement\_azureadb2c) | >= 0.4.0, < 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.38.0 |
| <a name="provider_azureadb2c"></a> [azureadb2c](#provider\_azureadb2c) | >= 0.4.0, < 1.0.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_app_registrations"></a> [custom\_app\_registrations](#module\_custom\_app\_registrations) | ./modules/app-registration | n/a |
| <a name="module_identity_experience_framework_app_registration"></a> [identity\_experience\_framework\_app\_registration](#module\_identity\_experience\_framework\_app\_registration) | ./modules/app-registration | n/a |
| <a name="module_proxy_identity_experience_framework_app_registration"></a> [proxy\_identity\_experience\_framework\_app\_registration](#module\_proxy\_identity\_experience\_framework\_app\_registration) | ./modules/app-registration | n/a |

## Resources

| Name | Type |
|------|------|
| [azureadb2c_application_patch.custom_app_registrations](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/application_patch) | resource |
| [azureadb2c_application_patch.identity_experience_framework_app_registration](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/application_patch) | resource |
| [azureadb2c_organizational_branding_localization.default](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/organizational_branding_localization) | resource |
| [azureadb2c_organizational_branding_localization.this](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/organizational_branding_localization) | resource |
| [azureadb2c_trustframework_keyset_certificate.certificate_keysets](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/trustframework_keyset_certificate) | resource |
| [azureadb2c_trustframework_keyset_key.encryption](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/trustframework_keyset_key) | resource |
| [azureadb2c_trustframework_keyset_key.key_keysets](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/trustframework_keyset_key) | resource |
| [azureadb2c_trustframework_keyset_key.signing](https://registry.terraform.io/providers/Schumann-IT/azureadb2c/latest/docs/resources/trustframework_keyset_key) | resource |
| [azurerm_resource_group.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.template_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azuread_application.existing_custom_app_registrations](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_application.extensions_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
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
| <a name="input_custom_app_registrations"></a> [custom\_app\_registrations](#input\_custom\_app\_registrations) | A list of custom app registrations to create or update. For details see modules/app-registration | `any` | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the b2c directory domain | `string` | n/a | yes |
| <a name="input_identity_experience_framework_app_registration_object_id"></a> [identity\_experience\_framework\_app\_registration\_object\_id](#input\_identity\_experience\_framework\_app\_registration\_object\_id) | The object ID of the app registration for the identity experience framework | `string` | n/a | yes |
| <a name="input_keysets"></a> [keysets](#input\_keysets) | A list of keysets to create or update | <pre>list(object({<br>    name                 = string<br>    use                  = optional(string, null)<br>    type                 = optional(string, null)<br>    certificate          = optional(string, null)<br>    certificate_password = optional(string, null)<br>    secret               = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_localizations"></a> [localizations](#input\_localizations) | A list of organization branding localizations to create or update | <pre>list(object({<br>    lang                   = string,<br>    background_color       = optional(string, null),<br>    banner_logo_file       = optional(string, null),<br>    background_image_file  = optional(string, null),<br>    square_logo_light_file = optional(string, null),<br>    square_logo_dark_file  = optional(string, null),<br>    sign_in_page_text      = optional(string, null),<br>    username_hint_text     = optional(string, null),<br>  }))</pre> | `[]` | no |
| <a name="input_proxy_identity_experience_framework_app_registration_object_id"></a> [proxy\_identity\_experience\_framework\_app\_registration\_object\_id](#input\_proxy\_identity\_experience\_framework\_app\_registration\_object\_id) | The object ID of the app registration for the proxy identity experience framework | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the b2c directory has been created | `string` | n/a | yes |
| <a name="input_template_storage"></a> [template\_storage](#input\_template\_storage) | The storage account to use for the custom policy templates | <pre>object({<br>    manage                                       = bool<br>    existing_storage_account_name                = optional(string, null)<br>    existing_storage_account_resource_group_name = optional(string, null)<br>    existing_storage_container_name              = optional(string, null)<br>    storage_account_name                         = optional(string, null)<br>    storage_account_resource_group_name          = optional(string, null)<br>    storage_account_location                     = optional(string, null)<br>    storage_container_name                       = optional(string, null)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_app_registration_application_ids"></a> [custom\_app\_registration\_application\_ids](#output\_custom\_app\_registration\_application\_ids) | The application ids of the custom app registrations |
| <a name="output_custom_certificates"></a> [custom\_certificates](#output\_custom\_certificates) | The ids of the custom certificates in the identity experience framework |
| <a name="output_custom_keys"></a> [custom\_keys](#output\_custom\_keys) | The ids of the custom keys in the identity experience framework |
| <a name="output_extension_app_registration_application_id"></a> [extension\_app\_registration\_application\_id](#output\_extension\_app\_registration\_application\_id) | The application id of the extension app registration |
| <a name="output_extension_app_registration_object_id"></a> [extension\_app\_registration\_object\_id](#output\_extension\_app\_registration\_object\_id) | The object id of the extension app registration |
| <a name="output_identity_experience_framework_application_id"></a> [identity\_experience\_framework\_application\_id](#output\_identity\_experience\_framework\_application\_id) | The application id of the identity experience framework app registration |
| <a name="output_identity_experience_framework_encryption_key_id"></a> [identity\_experience\_framework\_encryption\_key\_id](#output\_identity\_experience\_framework\_encryption\_key\_id) | The id of the encryption key in the identity experience framework |
| <a name="output_identity_experience_framework_signing_key_id"></a> [identity\_experience\_framework\_signing\_key\_id](#output\_identity\_experience\_framework\_signing\_key\_id) | The id of the signing key in the identity experience framework |
| <a name="output_localizations"></a> [localizations](#output\_localizations) | The localizations |
| <a name="output_proxy_identity_experience_framework_application_id"></a> [proxy\_identity\_experience\_framework\_application\_id](#output\_proxy\_identity\_experience\_framework\_application\_id) | The application id of the proxy identity experience framework app registration |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | The name of the storage container |
<!-- END_TF_DOCS -->
