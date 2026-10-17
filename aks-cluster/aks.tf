resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = data.azurerm_resource_group.aks.location
  resource_group_name = data.azurerm_resource_group.aks.name
  dns_prefix          = "aks-prod"

  sku_tier           = "Standard"
  kubernetes_version = var.kubernetes_version

  role_based_access_control_enabled = true
  local_account_disabled            = true

  azure_active_directory_role_based_access_control {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    azure_rbac_enabled = true
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    vm_size        = "Standard_D2s_v3"
    node_count     = var.system_node_count
    vnet_subnet_id = azurerm_subnet.system.id

    type                         = "VirtualMachineScaleSets"
    auto_scaling_enabled         = true
    min_count                    = 1
    max_count                    = 2
    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "10%"
    }

    tags = {
      NodePool = "system"
    }
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_data_plane  = "azure"
    network_policy      = "azure"

    pod_cidr       = "192.168.0.0/16"
    service_cidr   = "172.20.0.0/16"
    dns_service_ip = "172.20.0.10"

    outbound_type = "userAssignedNATGateway"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  node_provisioning_profile {
    mode = "Manual"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }

  depends_on = [
    azurerm_subnet_nat_gateway_association.system,
    azurerm_subnet_nat_gateway_association.user
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size        = "Standard_D2s_v3"
  mode           = "User"
  vnet_subnet_id = azurerm_subnet.user.id

  auto_scaling_enabled = true
  min_count            = var.user_min_node_count
  max_count            = var.user_max_node_count

  node_labels = {
    workload = "applications"
  }

  tags = {
    NodePool = "user"
  }
}
