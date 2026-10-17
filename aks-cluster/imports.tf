import {
  to = azurerm_virtual_network.aks
  id = local.aks_virtual_network_id
}

import {
  to = azurerm_subnet.system
  id = local.aks_system_subnet_id
}

import {
  to = azurerm_subnet.user
  id = local.aks_user_subnet_id
}

import {
  to = azurerm_public_ip.nat
  id = local.aks_public_ip_id
}

import {
  to = azurerm_nat_gateway.aks
  id = local.aks_nat_gateway_id
}

import {
  to = azurerm_nat_gateway_public_ip_association.aks
  id = "${local.aks_nat_gateway_id}|${local.aks_public_ip_id}"
}

import {
  to = azurerm_subnet_nat_gateway_association.system
  id = "${local.aks_system_subnet_id}|${local.aks_nat_gateway_id}"
}

import {
  to = azurerm_subnet_nat_gateway_association.user
  id = "${local.aks_user_subnet_id}|${local.aks_nat_gateway_id}"
}

import {
  to = azurerm_container_registry.aks
  id = "${data.azurerm_resource_group.aks.id}/providers/Microsoft.ContainerRegistry/registries/${var.acr_name}"
}

import {
  to = azurerm_log_analytics_workspace.aks
  id = "${data.azurerm_resource_group.aks.id}/providers/Microsoft.OperationalInsights/workspaces/log-${var.cluster_name}"
}