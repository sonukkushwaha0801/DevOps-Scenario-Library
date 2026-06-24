resource "azurerm_resource_group" "name" {
  name     = "terraform-drift-detected-rg"
  location = "Central India"
}

resource "azurerm_virtual_network" "name" {
  name                = "terraform-drift-detected-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
}

resource "azurerm_subnet" "name" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.name.name
  virtual_network_name = azurerm_virtual_network.name.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "name" {
  name                = "terraform-drift-detected-ip"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "name" {
  name                = "terraform-drift-detected-nic"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.name.id
  }
}

resource "azurerm_linux_virtual_machine" "name" {
  name                = "terraform-drift-detected"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  size                = lookup(var.instance_type, var.environment, "Standard_B1s")
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.name.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
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
    Name = "Terraform-Drift-Detected"
  }
}
