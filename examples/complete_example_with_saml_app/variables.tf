variable "client_id" {
  type        = string
  description = "The client id of the service principal for Azure B2C Directory"
}

variable "client_secret" {
  type        = string
  description = "The client secret of the service principal for Azure B2C Directory"
}

variable "domain_name" {
  type        = string
  description = "The domain name of the Azure B2C Directory"
}

variable "identity_experience_framework_app_registration_object_id" {
  type        = string
  description = "The object id of the Identity Experience Framework app registration"
}

variable "proxy_identity_experience_framework_app_registration_object_id" {
  type        = string
  description = "The object id of the Proxy Identity Experience Framework app registration"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name where Azure B2C Directory has been created"
}

variable "saml_app_registration_object_id" {
  type        = string
  description = "The object id of the SAML app registration"
}

variable "saml_certificate" {
  type        = string
  description = "The certificate for the SAML application"
}

variable "saml_certificate_password" {
  type        = string
  description = "The password for the SAML application certificate"
}

variable "saml_identifier_uri" {
  type        = string
  description = "he identifier URI for the SAML application"
}

variable "saml_metadata_url" {
  type        = string
  description = "The metadata URL for the SAML application"
}
