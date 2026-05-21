## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_insights_api_key_enable | Enable creation of Application Insights API Key | `bool` | `false` | no |
| app_insights_connection_string | Connection string of App Insights | `string` | `null` | no |
| app_insights_id | ID of the existing Application Insights resource to use | `string` | `null` | no |
| app_insights_instrumentation_key | Instrumentation key of Application Insights | `string` | `null` | no |
| app_settings | Application settings for the Static Web App | `map(string)` | `{}` | no |
| application_insights_enabled | Enable Application Insights integration | `bool` | `true` | no |
| basic_auth | Basic authentication block for the Static Web App | `object` | `null` | no |
| configuration_file_changes_enabled | Whether `staticwebapp.config.json` file changes can update runtime configuration | `bool` | `true` | no |
| custom_name | Define your custom name to override default naming convention | `string` | `null` | no |
| deployment_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| enable_diagnostic | Enable diagnostic settings for the Static Web App | `bool` | `false` | no |
| enable_private_endpoint | Enable or disable private endpoint for the Static Web App | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`) | `string` | `null` | no |
| extra_tags | Variable to pass extra tags | `map(string)` | `null` | no |
| identity | Map with identity block information | <pre>object({<br>  type         = string<br>  identity_ids = list(string)<br>})</pre> | <pre>{<br>  type = "SystemAssigned"<br>  identity_ids = []<br>}</pre> | no |
| label_order | The order of labels used to construct resource names or tags | `list(string)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the Static Web App is created | `string` | `null` | no |
| log_analytics_workspace_id | Log Analytics Workspace ID for diagnostic logs | `string` | `null` | no |
| log_enabled | Enable log categories for diagnostic settings | `bool` | `false` | no |
| managedby | ManagedBy, eg `terraform-az-modules` | `string` | `"terraform-az-modules"` | no |
| metric_enabled | Enable metrics for diagnostic settings | `bool` | `true` | no |
| name | Name (e.g. `app` or `cluster`) | `string` | `null` | no |
| preview_environments_enabled | Whether preview (staging) environments are enabled | `bool` | `true` | no |
| private_dns_zone_ids | Id of the private DNS Zone | `string` | `null` | no |
| private_endpoint_subnet_id | Subnet ID for private endpoint | `string` | `null` | no |
| public_network_access_enabled | Whether enable public access for the Static Web App | `bool` | `false` | no |
| read_permissions | Read permissions for telemetry | `list(string)` | <pre>[<br>  "aggregate",<br>  "api",<br>  "draft",<br>  "extendqueries",<br>  "search"<br>]</pre> | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azurerm-static-web-app"` | no |
| resource_group_name | A container that holds related resources for an Azure solution | `string` | `""` | no |
| resource_position_prefix | Controls the placement of the resource type keyword in the resource name | `bool` | `true` | no |
| sku_size | SKU size for the Static Web App. Possible values are `Free` and `Standard`. | `string` | `"Free"` | no |
| sku_tier | SKU tier for the Static Web App. Possible values are `Free` and `Standard`. | `string` | `"Free"` | no |
| storage_account_id | Storage Account ID for diagnostic logs (optional) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| static_web_app_api_key | API key of the Static Web App used by deployment automation (sensitive). |
| static_web_app_default_host_name | Default host name associated with the Static Web App |
| static_web_app_id | Id of the Static Web App |
| static_web_app_identity | Managed identity info for the Static Web App |
| static_web_app_name | Name of the Static Web App |