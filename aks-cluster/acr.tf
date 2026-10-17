resource "azurerm_container_registry" "aks" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location

  sku           = "Standard"
  admin_enabled = false

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Grant the AKS kubelet identity permission to pull images from ACR.
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.aks.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "aks_cluster_admin" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = data.azurerm_client_config.current.object_id
}
