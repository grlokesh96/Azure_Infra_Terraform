data "azurerm_resource_group" "aks" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

locals {
  aks_virtual_network_id = "${data.azurerm_resource_group.aks.id}/providers/Microsoft.Network/virtualNetworks/vnet-aks-prod"
  aks_system_subnet_id   = "${local.aks_virtual_network_id}/subnets/snet-aks-system"
  aks_user_subnet_id     = "${local.aks_virtual_network_id}/subnets/snet-aks-user"
  aks_public_ip_id       = "${data.azurerm_resource_group.aks.id}/providers/Microsoft.Network/publicIPAddresses/pip-aks-nat"
  aks_nat_gateway_id     = "${data.azurerm_resource_group.aks.id}/providers/Microsoft.Network/natGateways/nat-aks-prod"
}
