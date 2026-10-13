locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${local.name_prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks-nodes"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.aks_subnet_prefix
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${local.name_prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = local.name_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.environment == "prod" ? "Standard" : "Free"
  tags                = var.tags

  default_node_pool {
    name                = "system"
    vm_size             = var.system_node_vm_size
    vnet_subnet_id      = azurerm_subnet.aks.id
    zones               = var.availability_zones
    auto_scaling_enabled = true
    min_count           = var.system_node_min_count
    max_count           = var.system_node_max_count
    os_disk_size_gb     = 64
    os_disk_type        = "Managed"
    type                = "VirtualMachineScaleSets"
    only_critical_addons_enabled = false
  }

  identity {
    type = "SystemAssigned"
  }

  # Azure CNI gives pods IPs from the subnet, so the subnet must be sized accordingly.
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.20.0.0/16"
    dns_service_ip    = "10.20.0.10"
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    admin_group_object_ids = var.admin_group_object_ids
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  local_account_disabled    = true

  automatic_upgrade_channel = "patch"
  image_cleaner_enabled     = true
  image_cleaner_interval_hours = 48
}

# The cluster's managed identity needs Network Contributor on the subnet
# so AKS can attach node NICs and load balancers to it.
resource "azurerm_role_assignment" "aks_subnet" {
  scope                = azurerm_subnet.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id
}
