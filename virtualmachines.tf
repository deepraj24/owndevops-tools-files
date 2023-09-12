resource "azurerm_network_interface" "appinterface" {
  count = var.number_of_machines
  name                = "appinterface${count.index}"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.appip[count.index].id
  }
  depends_on = [ 
    azurerm_subnet.subnets,
    azurerm_public_ip.appi
  ]
}

resource "azurerm_public_ip" "appip" {
  count = var.number_of_machines
  name                = "app-ip${count.index}"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  depends_on = [ 
    azurerm_resource_group.terragrp
   ]
}