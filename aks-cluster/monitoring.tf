resource "azurerm_log_analytics_workspace" "aks" {
  name                = "log-${var.cluster_name}"
  location            = data.azurerm_resource_group.aks.location
  resource_group_name = data.azurerm_resource_group.aks.name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
