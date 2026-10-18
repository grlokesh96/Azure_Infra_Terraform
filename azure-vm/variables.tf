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

variable "admin_password" {
  description = "Password for the Linux administrator account"
  type        = string
  sensitive   = true

  validation {
    condition = (
      length(var.admin_password) >= 12 &&
      length(var.admin_password) <= 72 &&
      can(regex("[A-Z]", var.admin_password)) &&
      can(regex("[a-z]", var.admin_password)) &&
      can(regex("[0-9]", var.admin_password)) &&
      can(regex("[^A-Za-z0-9]", var.admin_password))
    )
    error_message = "admin_password must be 12-72 characters and include upper case, lower case, numeric and special characters."
  }
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
