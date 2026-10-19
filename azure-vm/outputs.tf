output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "Public IP address of the Virtual Machine"
}

output "ssh_private_key" {
  value       = tls_private_key.ssh_key.private_key_pem
  description = "Private SSH key to connect to the VM"
  sensitive   = true
}

output "ssh_connection_command" {
  value       = "ssh -i id_rsa ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
  description = "Command to connect to the VM once key is extracted"
}
