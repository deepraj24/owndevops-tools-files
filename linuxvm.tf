/*
#Create Network Security grp for Linux VM(For 265 to 337 line require for Linux VM)
resource "azurerm_network_security_group" "appnsg" {
  name                = "app-nsg"
  location            = local.location
  resource_group_name = local.resource_group_name
  security_rule {
    name                       = "AllowSSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [ 
    azurerm_resource_group.terragrp
   ]
}
resource "azurerm_subnet_network_security_group_association" "appnsglink" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.appnsg.id
}

#Create a key for Linux VM(I want to get the content of that file, that private key, so that i can use that private key log into the linux vm)
#Destrotion time issue will be created with linuxkey.pem file. So, cann't run this linuxvm.
resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxpemkey" {
  filename = "linuxkey.pem"
  content = tls_private_key.linuxkey.private_key_pem
  depends_on = [ 
    tls_private_key.linuxkey
   ]
}

#Creating Linux Virtual machine
resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = "linuxvm"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_D2s_v3"
  admin_username      = "linuxusr"
  network_interface_ids = [
    azurerm_network_interface.appinterface.id
  ]

   admin_ssh_key {
     username="linuxusr"
     public_key = tls_private_key.linuxkey.public_key_openssh
   }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.appinterface,
    azurerm_resource_group.terragrp,
    tls_private_key.linuxkey
    
  ]
} 
*/
