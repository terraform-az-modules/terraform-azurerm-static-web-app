##-----------------------------------------------------------------------------
## Provider
##-----------------------------------------------------------------------------
provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.4"
  name        = "core"
  environment = "dev"
  label_order = ["environment", "name", "location"]
  location    = "centralus"
}

##-----------------------------------------------------------------------------
## Virtual Network
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Subnet for Private Endpoint
##-----------------------------------------------------------------------------
module "subnet-ep" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "dev"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name
  subnets = [
    {
      name            = "sub3"
      subnet_prefixes = ["10.0.3.0/24"]
    }
  ]
  enable_route_table = false
}

##-----------------------------------------------------------------------------
## Log Analytics
##-----------------------------------------------------------------------------
module "log-analytics" {
  source              = "terraform-az-modules/log-analytics/azurerm"
  version             = "1.0.2"
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

##-----------------------------------------------------------------------------
## Private DNS Zone
##-----------------------------------------------------------------------------
module "private-dns-zone" {
  source              = "terraform-az-modules/private-dns/azurerm"
  version             = "1.0.2"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  label_order         = ["name", "environment", "location"]
  name                = "core"
  environment         = "dev"
  private_dns_config = [
    {
      resource_type = "custom_dns"
      zone_name     = "privatelink.azurestaticapps.net"
      vnet_ids      = [module.vnet.vnet_id]
    },
  ]
}

##-----------------------------------------------------------------------------
## Application Insights
##-----------------------------------------------------------------------------
module "application-insights" {
  source                     = "terraform-az-modules/application-insights/azurerm"
  version                    = "1.0.1"
  name                       = "core"
  environment                = "dev"
  label_order                = ["name", "environment", "location"]
  resource_group_name        = module.resource_group.resource_group_name
  location                   = module.resource_group.resource_group_location
  workspace_id               = module.log-analytics.workspace_id
  log_analytics_workspace_id = module.log-analytics.workspace_id
  web_test_enable            = false
}

##-----------------------------------------------------------------------------
## Static Web App
##-----------------------------------------------------------------------------
module "static-web-app" {
  source              = "../.."
  depends_on          = [module.vnet, module.subnet-ep]
  enable              = true
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  # Static Web App SKU (Standard required for VNet/private endpoint and basic auth).
  sku_tier = "Standard"
  sku_size = "Standard"

  preview_environments_enabled       = true
  configuration_file_changes_enabled = true

  # VNet and Private Endpoint Integration
  private_endpoint_subnet_id    = module.subnet-ep.subnet_ids["sub3"]
  enable_private_endpoint       = true
  private_dns_zone_ids          = [module.private-dns-zone.private_dns_zone_ids["custom_dns"]]
  public_network_access_enabled = false

  # Basic auth for non-production environments
  basic_auth = {
    password     = "Str0ng-Pass@123"
    environments = "StagingEnvironments"
  }

  # Application Insights / App Settings
  app_settings = {
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
  }
  app_insights_id                  = module.application-insights.app_insights_id
  app_insights_instrumentation_key = module.application-insights.instrumentation_key
  app_insights_connection_string   = module.application-insights.connection_string

  # Diagnostic Settings
  enable_diagnostic          = true
  log_analytics_workspace_id = module.log-analytics.workspace_id
}
