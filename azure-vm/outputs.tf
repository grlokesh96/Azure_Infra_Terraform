output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "vm_name" {
  description = "Virtual machine name"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "vm_size" {
  description = "Virtual machine size"
  value       = azurerm_linux_virtual_machine.vm.size
}

output "private_ip_address" {
  description = "VM private IP"
  value       = azurerm_network_interface.vm.private_ip_address
}

output "public_ip_address" {
  description = "VM public IP"
  value       = azurerm_public_ip.vm.ip_address
}

output "vm_identity_principal_id" {
  description = "System assigned managed identity principal ID"
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}
