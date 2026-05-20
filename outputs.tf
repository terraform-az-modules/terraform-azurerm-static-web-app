##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "static_web_app_id" {
  description = "Id of the Static Web App"
  value       = length(azurerm_static_web_app.main) > 0 ? azurerm_static_web_app.main[0].id : null
}

output "static_web_app_name" {
  description = "Name of the Static Web App"
  value       = length(azurerm_static_web_app.main) > 0 ? azurerm_static_web_app.main[0].name : null
}

output "static_web_app_default_host_name" {
  description = "The default host name associated with the Static Web App"
  value       = length(azurerm_static_web_app.main) > 0 ? azurerm_static_web_app.main[0].default_host_name : null
}

output "static_web_app_api_key" {
  description = "The API key of the Static Web App used by deployment automation. Sensitive."
  value       = length(azurerm_static_web_app.main) > 0 ? azurerm_static_web_app.main[0].api_key : null
  sensitive   = true
}

output "static_web_app_identity" {
  value = length(azurerm_static_web_app.main) > 0 ? [
    for id in azurerm_static_web_app.main[0].identity : {
      principal_id = id.principal_id
      type         = id.type
    }
  ] : []
  description = "Managed identity info for the Static Web App (empty if not created)"
}
