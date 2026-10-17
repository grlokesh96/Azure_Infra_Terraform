variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-devops-vm"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "vm-devops-01"
}

variable "vm_size" {
  description = "VM SKU"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_cidr" {
  description = "Specific CIDR allowed to reach SSH"
  type        = string

  validation {
    condition = can(cidrhost(var.allowed_ssh_cidr, 0)) && !contains([
      "0.0.0.0/0",
      "::/0",
      "*",
      "Internet"
    ], var.allowed_ssh_cidr)
    error_message = "allowed_ssh_cidr must be a specific CIDR and cannot allow access from the entire internet."
  }
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
