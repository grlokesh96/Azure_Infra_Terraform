resource "azurerm_virtual_network" "aks" {
  name                = "vnet-aks-prod"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "system" {
  name                 = "snet-aks-system"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "user" {
  name                 = "snet-aks-user"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.2.0/23"]
}

resource "azurerm_public_ip" "nat" {
  name                = "pip-aks-nat"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_nat_gateway" "aks" {
  name                = "nat-aks-prod"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name

  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "aks" {
  nat_gateway_id       = azurerm_nat_gateway.aks.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "system" {
  subnet_id      = azurerm_subnet.system.id
  nat_gateway_id = azurerm_nat_gateway.aks.id

  depends_on = [
    azurerm_nat_gateway_public_ip_association.aks
  ]
}

resource "azurerm_subnet_nat_gateway_association" "user" {
  subnet_id      = azurerm_subnet.user.id
  nat_gateway_id = azurerm_nat_gateway.aks.id

  depends_on = [
    azurerm_nat_gateway_public_ip_association.aks
  ]
}
