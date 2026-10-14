variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  type    = string
  default = "rg-aks-prod"
}

variable "cluster_name" {
  type    = string
  default = "aks-prod"
}

variable "acr_name" {
  description = "Globally unique ACR name; alphanumeric only"
  type        = string
}

variable "kubernetes_version" {
  description = "Supported AKS Kubernetes version"
  type        = string
  default     = null
}

variable "system_node_count" {
  type    = number
  default = 2
}

variable "user_min_node_count" {
  type    = number
  default = 1
}

variable "user_max_node_count" {
  type    = number
  default = 2
}
