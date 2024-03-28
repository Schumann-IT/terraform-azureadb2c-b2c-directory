variable "client_id" {
  type        = string
  description = "The Client ID which should be used when authenticating as a service principal."
}

variable "client_secret" {
  type        = string
  description = "The application password to be used when authenticating using a client secret."
}

variable "domain_name" {
  type        = string
  description = "The name of the b2c directory domain"
}

variable "identity_experience_framework_app_registration_object_id" {
  type        = string
  description = "The object ID of the app registration for the identity experience framework"
}

variable "proxy_identity_experience_framework_app_registration_object_id" {
  type        = string
  description = "The object ID of the app registration for the proxy identity experience framework"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the b2c directory has been created"
}

variable "template_storage" {
  type = object({
    manage                                       = bool
    existing_storage_account_name                = optional(string, null)
    existing_storage_account_resource_group_name = optional(string, null)
    existing_storage_container_name              = optional(string, null)
    storage_account_name                         = optional(string, null)
    storage_account_resource_group_name          = optional(string, null)
    storage_account_location                     = optional(string, null)
    storage_container_name                       = optional(string, null)
  })
  description = "The storage account to use for the custom policy templates"

  validation {
    condition     = var.template_storage.manage == true && !(var.template_storage.storage_account_resource_group_name != null && var.template_storage.storage_account_location == null)
    error_message = "If the storage account resource group name is specified, the storage account location must also be specified"
  }
  validation {
    condition     = var.template_storage.manage == true && !(var.template_storage.existing_storage_account_name != null && var.template_storage.existing_storage_account_resource_group_name == null)
    error_message = "If the existing storage account name is specified, the existing storage account resource group name must also be specified"
  }
}

variable "custom_app_registrations" {
  type = list(object({
    create                     = optional(bool, false)
    app_registration_object_id = optional(string, null)
    config = object({
      display_name                   = optional(string, null)
      fallback_public_client_enabled = optional(bool, false)
      api = object({
        known_client_applications      = optional(list(string), [])
        mapped_claims_enabled          = optional(bool, false)
        requested_access_token_version = number
      })
      web = optional(object({
        enabled                       = optional(bool, false)
        redirect_uris                 = optional(list(string), [])
        logout_url                    = optional(string, null)
        access_token_issuance_enabled = optional(bool, false)
        id_token_issuance_enabled     = optional(bool, false)
      }), {})
      public_client = optional(object({
        enabled       = optional(bool, false)
        redirect_uris = optional(list(string), [])
      }), {})
      required_graph_api_permissions = optional(list(string), [])
      identifier_uri                 = optional(string, "")
      domain_name                    = optional(string, "")
      permission_scopes = optional(list(object({
        name                       = string
        consent_type               = optional(string, "Admin")
        admin_consent_description  = string
        admin_consent_display_name = string
      })), [])
      required_resource_access = optional(map(list(string)), {})
    })
    patch = optional(object({
      file              = string
      saml_metadata_url = optional(string, null)
    }), null)
  }))
  default     = []
  description = "A list of custom app registrations to create or update"

  validation {
    condition     = length([for app in var.custom_app_registrations : app if app.create == true]) == length([for app in var.custom_app_registrations : app if app.create == true && app.app_registration_object_id != null])
    error_message = "If the create flag is set to true, the app registration object ID must also be specified"
  }
}

variable "keysets" {
  type = list(object({
    name                 = string
    use                  = optional(string, null)
    type                 = optional(string, null)
    certificate          = optional(string, null)
    certificate_password = optional(string, null)
  }))
  default     = []
  description = "A list of keysets to create or update"

  validation {
    condition     = length([for keyset in var.keysets : keyset if keyset.certificate != null]) == length([for keyset in var.keysets : keyset if keyset.certificate != null && keyset.certificate_password != null])
    error_message = "If a certificate is specified, a certificate password must also be specified"
  }
  validation {
    condition     = length([for keyset in var.keysets : keyset if keyset.certificate == null && keyset.use != null]) == length([for keyset in var.keysets : keyset if keyset.certificate == null && keyset.use == null && keyset.type == null])
    error_message = "Either certificate and certificate_password OR use and type must be specified"
  }
  validation {
    condition     = length([for keyset in var.keysets : keyset if keyset.use != null && keyset.certificate == null]) == length([for keyset in var.keysets : keyset if keyset.certificate == null && keyset.type == null])
    error_message = "If a use is specified, type must also be specified"
  }
  validation {
    condition     = length([for keyset in var.keysets : keyset if keyset.type != null && keyset.certificate == null]) == length([for keyset in var.keysets : keyset if keyset.certificate == null && keyset.use == null])
    error_message = "If a type is specified, use must also be specified"
  }
}

variable "localizations" {
  type = list(object({
    lang                   = string,
    background_color       = optional(string, null),
    banner_logo_file       = optional(string, null),
    background_image_file  = optional(string, null),
    square_logo_light_file = optional(string, null),
    square_logo_dark_file  = optional(string, null),
    sign_in_page_text      = optional(string, null),
    username_hint_text     = optional(string, null),
  }))
  default = []
  description = "A list of organization branding localizations to create or update"
}
