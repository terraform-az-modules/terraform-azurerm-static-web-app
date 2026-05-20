##-----------------------------------------------------------------------------
## Tagging Module – Applies standard tags to all resources
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-----------------------------------------------------------------------------
## Static Web App
##-----------------------------------------------------------------------------
resource "azurerm_static_web_app" "main" {
  count                              = var.enable ? 1 : 0
  name                               = var.resource_position_prefix ? format("stapp-%s", local.name) : format("%s-stapp", local.name)
  resource_group_name                = var.resource_group_name
  location                           = var.location
  sku_tier                           = var.sku_tier
  sku_size                           = var.sku_size
  preview_environments_enabled       = var.preview_environments_enabled
  public_network_access_enabled      = var.public_network_access_enabled
  configuration_file_changes_enabled = var.configuration_file_changes_enabled

  app_settings = local.app_settings

  dynamic "identity" {
    for_each = [var.identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "basic_auth" {
    for_each = var.basic_auth == null ? [] : [var.basic_auth]
    content {
      password     = basic_auth.value.password
      environments = basic_auth.value.environments
    }
  }

  tags = module.labels.tags

  lifecycle {
    ignore_changes = [
      app_settings,
    ]
  }
}

##-----------------------------------------------------------------------------
## Private Endpoint for Static Web App
##-----------------------------------------------------------------------------
resource "azurerm_private_endpoint" "pep" {
  count               = var.enable && var.enable_private_endpoint ? 1 : 0
  name                = format("pe-%s", azurerm_static_web_app.main[0].name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = module.labels.tags
  private_service_connection {
    name                           = var.resource_position_prefix ? format("psc-static-web-app-%s", local.name) : format("%s-psc-static-web-app", local.name)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_static_web_app.main[0].id
    subresource_names              = ["staticSites"]
  }

  private_dns_zone_group {
    name                 = var.resource_position_prefix ? format("swa-dns-zone-group-%s", local.name) : format("%s-swa-dns-zone-group", local.name)
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

##-----------------------------------------------------------------------------
## Telemetry / Application Insights API Key
##-----------------------------------------------------------------------------
resource "azurerm_application_insights_api_key" "read_telemetry" {
  count                   = var.enable && var.app_insights_api_key_enable ? 1 : 0
  name                    = var.resource_position_prefix ? format("appi-api-key-%s", local.name) : format("%s-appi-api-key", local.name)
  application_insights_id = var.app_insights_id
  read_permissions        = var.read_permissions
}

##-----------------------------------------------------------------------------
## Diagnostic Settings for Static Web App
##-----------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "swa_diag" {
  count = var.enable && var.enable_diagnostic ? 1 : 0
  name  = var.resource_position_prefix ? format("diag-log-%s", local.name) : format("%s-diag-log", local.name)

  target_resource_id = azurerm_static_web_app.main[0].id

  storage_account_id         = var.storage_account_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = var.log_enabled ? ["allLogs"] : []
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = enabled_metric.value
    }
  }

  lifecycle {
    ignore_changes = [enabled_log, enabled_metric]
  }
}
