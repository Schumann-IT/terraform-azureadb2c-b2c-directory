## Simple example with OIDC app registration

### Prerequisites

- An IdP that supports OpenID Connect (e.g. Keycloak)
- An Azure subscription

### Usage

- create resource group and b2c tenant
- create service principal for terraform and update `main.tf` with the created service principal client id and client secret
- create app registrations (only provide the name and leave defaults) and update `main.tf` with the created app registration object ids
  - IdentityExperienceFramework
  - ProxyIdentityExperienceFramework
  - OIDC
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
  id = "/applications/<OidcId>"
  to = module.b2c.module.custom_app_registrations["<OidcId>"].azuread_application.this
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
- get the OIDC metadata from the OIDC app registration
```
https://example.b2clogin.com/example.onmicrosoft.com/B2C_1A_THE_POLICY/v2.0/.well-known/openid-configuration
```
- create a OIDC Identity Provider for your local IdP (e.g. https://www.keycloak.org/docs/latest/server_admin/#_identity_broker_oidc)
- update `main.tf` with the following information from your IdP
  - redirect url
- apply again
```bash
terraform apply 
```
- now the federation can be tested (in keycloak, the accounts client can be used)
