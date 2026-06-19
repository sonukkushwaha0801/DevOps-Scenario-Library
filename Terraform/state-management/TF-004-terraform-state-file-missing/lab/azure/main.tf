resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = var.location
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "vm-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = lookup(var.vm_size, var.environment, "Standard_B1s")
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.public_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    Name = var.environment
  }
}
