#Create Network Security grp for windows VM
/*
resource "azurerm_network_security_group" "appnsg" {
  name                = "app-nsg"
  location            = local.location
  resource_group_name = local.resource_group_name
  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
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


#Creating Windows Virtual machine
resource "azurerm_windows_virtual_machine" "appvm" {
  name                = "appvm"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_D2S_v3"
  admin_username      = "adminuser"
  admin_password      = "Azure@123"
  network_interface_ids = [
    azurerm_network_interface.appinterface.id,
    azurerm_network_interface.secondaryinterface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [ 
    azurerm_network_interface.appinterface,
    azurerm_resource_group.terragrp,
    azurerm_network_interface.secondaryinterface
  ]
}

resource "azurerm_network_interface" "secondaryinterface" {
  name                = "secondaryinterface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"    
  }
  depends_on = [
    azurerm_subnet.subnetA
  ]
}

#Resource azure manged disk and attache the data disk
resource "azurerm_managed_disk" "appdisk" {
  name                 = "appdisk"
  location             = local.location
  resource_group_name  = local.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "16"
}
resource "azurerm_virtual_machine_data_disk_attachment" "appdiskattach" {
  managed_disk_id    = azurerm_managed_disk.appdisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.appvm.id
  lun                = "0"
  caching            = "ReadWrite"
}
*/
