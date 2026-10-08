resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${local.name_prefix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  size = "Standard_D2s_v3"

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "osdisk-${local.name_prefix}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  encryption_at_host_enabled = true

  secure_boot_enabled = true
  vtpm_enabled        = true

  patch_mode = "AutomaticByPlatform"

  reboot_setting = "IfRequired"

  provision_vm_agent = true

  boot_diagnostics {}

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}
