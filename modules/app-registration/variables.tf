variable "create" {
  description = "Whether to create the application. If set to false, the application must exist and specified with var.object_id."
  type        = bool
  default     = false
}

variable "object_id" {
  description = "The object id of the application. If create is set to false, this must be specified."
  type        = string
  default     = null
}

variable "config" {
  description = "The application config."
  type = object({
    display_name                   = optional(string, null)
    fallback_public_client_enabled = optional(bool, false)
    sign_in_audience               = optional(string, "AzureADMyOrg")
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
    }), { enabled = false })
    public_client = optional(object({
      enabled       = optional(bool, false)
      redirect_uris = optional(list(string), [])
    }), { enabled = false })
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

  validation {
    condition     = !(length(var.config.permission_scopes) > 0 && (var.config.identifier_uri != "" && var.config.domain_name != ""))
    error_message = "identifier_uri or domain_name must be set if permission_scopes are defined."
  }
}
