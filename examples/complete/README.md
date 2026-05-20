<!-- BEGIN_TF_DOCS -->

# 🌐 Azure Static Web App

This example demonstrates how to deploy an **Azure Static Web App** using the module, including private endpoint integration, basic auth, Application Insights wiring, and diagnostic settings.

---

## ✅ Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.10.0 |
| Azurerm   | >= 4.0    |

---

## 🔌 Providers

No providers are explicitly defined in this example.

---

## 📦 Modules

| Name                 | Source                                              | Version |
|----------------------|-----------------------------------------------------|---------|
| application-insights | terraform-az-modules/application-insights/azurerm   | 1.0.1   |
| log-analytics        | terraform-az-modules/log-analytics/azurerm          | 1.0.2   |
| private-dns-zone     | terraform-az-modules/private-dns/azurerm            | 1.0.2   |
| resource_group       | terraform-az-modules/resource-group/azurerm         | 1.0.3   |
| static-web-app       | ../..                                               | n/a     |
| subnet-ep            | terraform-az-modules/subnet/azurerm                 | 1.0.1   |
| vnet                 | terraform-az-modules/vnet/azurerm                   | 1.0.3   |

---

<!-- END_TF_DOCS -->
