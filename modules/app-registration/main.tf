resource "azuread_application" "this" {
  display_name = var.create ? var.config.display_name : data.azuread_application.this[0].display_name

  fallback_public_client_enabled = var.config.fallback_public_client_enabled

  sign_in_audience = var.config.sign_in_audience

  api {
    known_client_applications      = var.config.api.known_client_applications
    mapped_claims_enabled          = var.config.api.mapped_claims_enabled
    requested_access_token_version = var.config.api.requested_access_token_version
  }

  dynamic "web" {
    for_each = var.config.web.enabled ? [1] : []

    content {
      redirect_uris = var.config.web.redirect_uris
      logout_url    = var.config.web.logout_url
      implicit_grant {
        access_token_issuance_enabled = var.config.web.access_token_issuance_enabled
        id_token_issuance_enabled     = var.config.web.id_token_issuance_enabled
      }
    }
  }

  dynamic "public_client" {
    for_each = var.config.public_client.enabled ? [1] : []

    content {
      redirect_uris = var.config.public_client.redirect_uris
    }
  }

  dynamic "required_resource_access" {
    for_each = length(var.config.required_graph_api_permissions) > 0 ? [1] : []

    content {
      resource_app_id = local.graph_api_resource_app_id

      dynamic "resource_access" {
        for_each = var.config.required_graph_api_permissions

        content {
          id   = resource_access.value
          type = "Scope"
        }
      }
    }
  }

  dynamic "required_resource_access" {
    for_each = var.config.required_resource_access

    content {
      resource_app_id = required_resource_access.key

      dynamic "resource_access" {
        for_each = required_resource_access.value

        content {
          id   = resource_access.value
          type = "Scope"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      identifier_uris,
      api[0].oauth2_permission_scope
    ]
  }
}

resource "azuread_application_identifier_uri" "this" {
  count = var.config.identifier_uri == "" && var.config.domain_name == "" ? 0 : 1

  application_id = azuread_application.this.id
  identifier_uri = var.config.identifier_uri == "" ? format("https://%s/%s", var.config.domain_name, azuread_application.this.client_id) : var.config.identifier_uri
}

resource "random_uuid" "permission_scopes" {
  for_each = toset([
    for s in var.config.permission_scopes : s.name
  ])
}

resource "azuread_application_permission_scope" "this" {
  for_each = {
    for s in var.config.permission_scopes : s.name => s
  }

  application_id = azuread_application.this.id
  scope_id       = random_uuid.permission_scopes[each.key].result
  value          = each.key
  type           = each.value.consent_type

  admin_consent_description  = each.value.admin_consent_description
  admin_consent_display_name = each.value.admin_consent_display_name

  depends_on = [
    azuread_application_identifier_uri.this
  ]
}
