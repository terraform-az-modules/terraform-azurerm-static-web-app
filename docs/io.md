## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_insights\_api\_key\_enable | Enable creation of Application Insights API Key | `bool` | `false` | no |
| app\_insights\_connection\_string | Connection string of App Insights | `string` | `null` | no |
| app\_insights\_id | ID of the existing Application Insights resource to use | `string` | `null` | no |
| app\_insights\_instrumentation\_key | Instrumentation key of Application Insights | `string` | `null` | no |
| app\_settings | Application settings for the Static Web App. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app#app_settings | `map(string)` | `{}` | no |
| application\_insights\_enabled | Enable Application Insights integration | `bool` | `true` | no |
| basic\_auth | Basic authentication block for the Static Web App. `environments` must be one of `AllEnvironments` or `StagingEnvironments`. | <pre>object({<br>    password     = string<br>    environments = string<br>  })</pre> | `null` | no |
| configuration\_file\_changes\_enabled | Whether `staticwebapp.config.json` file changes can update runtime configuration of the Static Web App. | `bool` | `true` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enable\_diagnostic | Enable diagnostic settings for the Static Web App | `bool` | `false` | no |
| enable\_private\_endpoint | Enable or disable private endpoint for the Static Web App. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `null` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| identity | Map with identity block information. | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | <pre>{<br>  "identity_ids": [],<br>  "type": "SystemAssigned"<br>}</pre> | no |
| label\_order | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(string)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the Static Web App is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| log\_analytics\_workspace\_id | Log Analytics Workspace ID for diagnostic logs | `string` | `null` | no |
| log\_enabled | Enable log categories for diagnostic settings | `bool` | `false` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| metric\_enabled | Enable metrics for diagnostic settings | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `null` | no |
| preview\_environments\_enabled | Whether preview (staging) environments are enabled for the Static Web App. | `bool` | `true` | no |
| private\_dns\_zone\_ids | List of IDs of the private DNS Zones | `list(string)` | `[]` | no |
| private\_endpoint\_subnet\_id | Subnet ID for private endpoint | `string` | `null` | no |
| public\_network\_access\_enabled | Whether enable public access for the Static Web App. | `bool` | `false` | no |
| read\_permissions | Read permissions for telemetry | `list(string)` | <pre>[<br>  "aggregate",<br>  "api",<br>  "draft",<br>  "extendqueries",<br>  "search"<br>]</pre> | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azurerm-static-web-app"` | no |
| resource\_group\_name | A container that holds related resources for an Azure solution | `string` | `""` | no |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "stapp-core-dev".<br>- If false, the keyword is appended: "core-dev-stapp".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| sku\_size | SKU size for the Static Web App. Possible values are `Free` and `Standard`. | `string` | `"Free"` | no |
| sku\_tier | SKU tier for the Static Web App. Possible values are `Free` and `Standard`. | `string` | `"Free"` | no |
| storage\_account\_id | Storage Account ID for diagnostic logs (optional) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| static\_web\_app\_api\_key | The API key of the Static Web App used by deployment automation. Sensitive. |
| static\_web\_app\_default\_host\_name | The default host name associated with the Static Web App |
| static\_web\_app\_id | Id of the Static Web App |
| static\_web\_app\_identity | Managed identity info for the Static Web App (empty if not created) |
| static\_web\_app\_name | Name of the Static Web App |

