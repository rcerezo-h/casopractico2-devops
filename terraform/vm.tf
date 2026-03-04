resource "azurerm_public_ip" "vm_pip" {
  name                = "pip-cp2-vm"
  location            = var.vm_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-cp2-vm"
  location            = var.vm_location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-cp2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.vm_location
  size                = var.vm_size
  admin_username      = var.vm_admin_username

  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = {
    environment = var.environment
  }
}
