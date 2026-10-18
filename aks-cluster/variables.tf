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
  default = "rg-aks-terraform"
}
variable "cluster_name" {
  type    = string
  default = "aks-terraform-demo"
}
variable "dns_prefix" {
  type    = string
  default = "akstfdemo"
}
variable "node_vm_size" {
  description = "Only the allowed VM size is accepted"
  type        = string
  default     = "Standard_D2s_v3"
  validation {
    condition     = var.node_vm_size == "Standard_D2s_v3"
    error_message = "Only Standard_D2s_v3 is allowed."
  }
}
variable "node_count" {
  description = "Fixed node count for the single node pool"
  type        = number
  default     = 1
  validation {
    condition     = var.node_count >= 1 && var.node_count <= 2
    error_message = "Node count must be 1 or 2."
  }
}
variable "authorized_ip_ranges" {
  description = "CIDR ranges allowed to reach the AKS API server (replace the placeholder with your trusted IP/CIDR)"
  type        = list(string)
  default     = ["203.0.113.10/32"]
  validation {
    condition     = length(var.authorized_ip_ranges) > 0
    error_message = "At least one authorized IP range must be specified to restrict API server access."
  }
}
variable "tags" {
  type = map(string)
  default = {
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
