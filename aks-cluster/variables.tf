variable "project_name" {
  description = "Short name used as a prefix for all resources."
  type        = string
  default     = "aks-demo"
}

variable "environment" {
  description = "Environment name (dev, qa, prod)."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "centralindia"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "Address prefix for the AKS node subnet."
  type        = list(string)
  default     = ["10.10.0.0/20"]
}

variable "kubernetes_version" {
  description = "Kubernetes version. Leave null to use the Azure default."
  type        = string
  default     = null
}

variable "system_node_vm_size" {
  description = "VM size for the default (system) node pool."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "system_node_min_count" {
  description = "Minimum number of nodes in the system node pool."
  type        = number
  default     = 1
}

variable "system_node_max_count" {
  description = "Maximum number of nodes in the system node pool."
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "Availability zones for the node pool. Not all regions support zones."
  type        = list(string)
  default     = []
}

variable "admin_group_object_ids" {
  description = "Entra ID group object IDs granted cluster-admin via Azure RBAC."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    managed_by = "terraform"
  }
}
