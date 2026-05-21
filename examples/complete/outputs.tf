##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "static_web_app_id" {
  description = "Id of the Static Web App"
  value       = module.static-web-app.static_web_app_id
}

output "static_web_app_name" {
  description = "Name of the Static Web App"
  value       = module.static-web-app.static_web_app_name
}

output "static_web_app_default_host_name" {
  description = "Default host name of the Static Web App"
  value       = module.static-web-app.static_web_app_default_host_name
}
