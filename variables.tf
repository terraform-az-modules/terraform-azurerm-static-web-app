##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "stapp-core-dev".
- If false, the keyword is appended: "core-dev-stapp".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = null
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "location" {
  type        = string
  default     = null
  description = "The location/region where the Static Web App is created. Changing this forces a new resource to be created."
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "label_order" {
  type        = list(string)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azurerm-static-web-app"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------
variable "enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "A container that holds related resources for an Azure solution"
}

##-----------------------------------------------------------------------------
## Static Web App
##-----------------------------------------------------------------------------
variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "SKU tier for the Static Web App. Possible values are `Free` and `Standard`."

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "The `sku_tier` value must be `Free` or `Standard`."
  }
}

variable "sku_size" {
  type        = string
  default     = "Free"
  description = "SKU size for the Static Web App. Possible values are `Free` and `Standard`."

  validation {
    condition     = contains(["Free", "Standard"], var.sku_size)
    error_message = "The `sku_size` value must be `Free` or `Standard`."
  }
}

variable "preview_environments_enabled" {
  type        = bool
  default     = true
  description = "Whether preview (staging) environments are enabled for the Static Web App."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether enable public access for the Static Web App."
}

variable "configuration_file_changes_enabled" {
  type        = bool
  default     = true
  description = "Whether `staticwebapp.config.json` file changes can update runtime configuration of the Static Web App."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application settings for the Static Web App. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app#app_settings"
}

variable "basic_auth" {
  type = object({
    password     = string
    environments = string
  })
  default     = null
  description = "Basic authentication block for the Static Web App. `environments` must be one of `AllEnvironments` or `StagingEnvironments`."

  validation {
    condition     = var.basic_auth == null || try(contains(["AllEnvironments", "StagingEnvironments"], var.basic_auth.environments), false)
    error_message = "When `basic_auth` is set, `environments` must be `AllEnvironments` or `StagingEnvironments`."
  }
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
  description = "Map with identity block information."
}

#------------------------------------------------------------------------------
## Private Endpoint and DNS Integration
#------------------------------------------------------------------------------
variable "enable_private_endpoint" {
  type        = bool
  default     = false
  description = "Enable or disable private endpoint for the Static Web App."
}

variable "private_endpoint_subnet_id" {
  type        = string
  default     = null
  description = "Subnet ID for private endpoint"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  default     = []
  description = "List of IDs of the private DNS Zones"
}

##-----------------------------------------------------------------------------
## Application Insights
##-----------------------------------------------------------------------------
variable "app_insights_id" {
  type        = string
  default     = null
  description = "ID of the existing Application Insights resource to use"
}

variable "read_permissions" {
  type        = list(string)
  default     = ["aggregate", "api", "draft", "extendqueries", "search"]
  description = "Read permissions for telemetry"
}

variable "app_insights_instrumentation_key" {
  type        = string
  default     = null
  description = "Instrumentation key of Application Insights"
}

variable "app_insights_connection_string" {
  type        = string
  default     = null
  description = "Connection string of App Insights"
}

variable "application_insights_enabled" {
  type        = bool
  default     = true
  description = "Enable Application Insights integration"
}

variable "app_insights_api_key_enable" {
  type        = bool
  default     = false
  description = "Enable creation of Application Insights API Key"
}

##-----------------------------------------------------------------------------
## Diagnostic Setting Variables
##-----------------------------------------------------------------------------
variable "enable_diagnostic" {
  description = "Enable diagnostic settings for the Static Web App"
  type        = bool
  default     = false
}

variable "storage_account_id" {
  description = "Storage Account ID for diagnostic logs (optional)"
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID for diagnostic logs"
  type        = string
  default     = null
}

variable "log_enabled" {
  description = "Enable log categories for diagnostic settings"
  type        = bool
  default     = false
}

variable "metric_enabled" {
  description = "Enable metrics for diagnostic settings"
  type        = bool
  default     = true
}
