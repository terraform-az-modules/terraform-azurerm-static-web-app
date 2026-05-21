<!-- BEGIN_TF_DOCS -->

# Azure Static Web App Module

This example demonstrates how to use the `terraform-azurerm-static-web-app` module. It deploys an Azure Static Web App with private endpoint integration, Application Insights, diagnostic settings, and supporting Azure infrastructure components.

---

## ✅ Requirements

| Name      | Version    |
|------------|------------|
| Terraform | >= 1.6.6   |
| Azurerm   | >= 3.116.0 |

---

## 🔌 Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.116.0 |

---

## 📦 Modules

| Name                   | Source                                         | Version |
|------------------------|------------------------------------------------|---------|
| resource_group         | terraform-az-modules/resource-group/azurerm   | 1.0.3   |
| vnet                   | terraform-az-modules/vnet/azurerm             | 1.0.3   |
| subnet-ep              | terraform-az-modules/subnet/azurerm           | 1.0.1   |
| log-analytics          | terraform-az-modules/log-analytics/azurerm    | 1.0.2   |
| private-dns-zone       | terraform-az-modules/private-dns/azurerm      | 1.0.2   |
| application-insights   | terraform-az-modules/application-insights/azurerm | 1.0.1 |
| static-web-app         | ../../                                         | n/a     |

---

## 🏗️ Resources

No additional resources are directly defined in this example.

---

## 🔧 Inputs

_No input variables are required for this example._

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `static_web_app_api_key` | API key of the Static Web App used by deployment automation (sensitive). |
| `static_web_app_default_host_name` | Default host name associated with the Static Web App. |
| `static_web_app_id` | ID of the Static Web App. |
| `static_web_app_identity` | Managed identity information of the Static Web App. |
| `static_web_app_name` | Name of the Static Web App. |

<!-- END_TF_DOCS -->