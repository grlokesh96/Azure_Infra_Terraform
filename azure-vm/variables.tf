variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "platform"
}

variable "admin_username" {
  description = "Linux administrator username"
  type        = string
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key authorized for the Linux administrator account"
  type        = string
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
