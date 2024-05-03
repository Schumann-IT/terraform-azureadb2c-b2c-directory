## Complete example with SAML app registration

### Prerequisites

- An IdP that supports SAML 2.0 (e.g. Keycloak)
- A Saml Certificate (https://learn.microsoft.com/en-us/azure/active-directory-b2c/saml-service-provider?tabs=macos&pivots=b2c-custom-policy#obtain-a-certificate) and passphrase
- An Azure subscription

### Usage

- create resource group and b2c tenant
- create service principal for terraform and update `main.tf` with the created service principal client id and client secret 
- create app registrations and update `main.tf` with the created app registration object ids
  - IdentityExperienceFramework
  - ProxyIdentityExperienceFramework
  - SAML
- update `main.tf` SAML certificate and passphrase
- create `imports.tf` to import the created app registrations to the state
```hcl
import {
  id = "/applications/<IdentityExperienceFrameworkId>"
  to = module.b2c.module.identity_experience_framework_app_registration.azuread_application.this
}

import {
  id = "/applications/<ProxyIdentityExperienceFrameworkId>"
  to = module.b2c.module.proxy_identity_experience_framework_app_registration.azuread_application.this
}

import {
  id = "/applications/<SamlId>"
  to = module.b2c.module.custom_app_registrations["<SamlId>"].azuread_application.this
}
```
- apply 
```bash
terraform init 
terraform apply 
```
- remove `imports.tf`
- plan should now be empty
```bash
terraform plan
```
- deploy some policies and note down the sign-in policy name for the next step
- get the SAML metadata from the SAML app registration
```
https://example.b2clogin.com/example.onmicrosoft.com/B2C_1A_THE_POLICY/Samlp/metadata
```
- create a SAML Identity Provider for your local IdP (e.g. https://www.keycloak.org/docs/latest/server_admin/#saml-v2-0-identity-providers)
- update `main.tf` with the following information from your IdP
  - saml_metadata_url
  - identifier_uri (issuer)
- apply again
```bash
terraform apply 
```
- now the federation can be tested (in keycloak, the accounts client can be used)
- please note the modified banner and background on auth pages
