##-----------------------------------------------------------------------------
## Locals
##-----------------------------------------------------------------------------
locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id

  default_app_settings = var.application_insights_enabled ? {
    for k, v in {
      APPINSIGHTS_INSTRUMENTATIONKEY        = var.app_insights_instrumentation_key
      APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
    } : k => v if v != null
  } : {}

  app_settings = merge(local.default_app_settings, var.app_settings)
}
