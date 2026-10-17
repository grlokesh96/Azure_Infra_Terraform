resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "AKS"
  }
}

data "azurerm_client_config" "current" {}
