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

variable "authorized_ip_ranges" {
  description = "CIDR ranges allowed to reach the AKS API server (empty means public access)"
  type        = list(string)

  validation {
    condition     = length(var.authorized_ip_ranges) > 0
    error_message = "At least one authorized IP range must be specified to restrict API server access."
  }
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
