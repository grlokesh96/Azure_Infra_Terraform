output "resource_group_name" {
  value       = azurerm_resource_group.aks.name
  description = "Resource group containing the AKS cluster"
}
output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "AKS cluster name"
}
output "aks_cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "AKS resource ID"
}
output "aks_fqdn" {
  value       = azurerm_kubernetes_cluster.aks.fqdn
  description = "AKS API server FQDN"
}
output "kube_config_command" {
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.aks.name}"
  description = "Command to configure kubectl access"
}
output "resource_group_name" {
  value       = azurerm_resource_group.aks.name
  description = "Resource group containing the AKS cluster"
}
output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "AKS cluster name"
}
output "aks_cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "AKS resource ID"
}
output "aks_fqdn" {
  value       = azurerm_kubernetes_cluster.aks.fqdn
  description = "AKS API server FQDN"
}
output "kube_config_command" {
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.aks.name}"
  description = "Command to configure kubectl access"
}
