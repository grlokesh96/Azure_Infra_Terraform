output "resource_group_name" {
  value = data.azurerm_resource_group.aks.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "acr_login_server" {
  value = azurerm_container_registry.aks.login_server
}

output "nat_public_ip" {
  value = azurerm_public_ip.nat.ip_address
}

output "get_credentials_command" {
  value = "az aks get-credentials --resource-group ${data.azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.aks.name}"
}
