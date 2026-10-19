variable "location" {
  type        = string
  default     = "east us"
  description = "Azure region for the VM resources"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-vm-platform"
  description = "Name of the Resource Group"
}

variable "vm_name" {
  type        = string
  default     = "vm-app-01"
  description = "Name of the Linux Virtual Machine"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "Allowed VM SKU size"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Administrator username for the VM"
}

variable "allowed_ssh_cidr" {
  type        = string
  default     = "0.0.0.0/0" # Replace with your workstation IP (e.g., "203.0.113.5/32") in production
  description = "CIDR block allowed to SSH into the VM"
}
