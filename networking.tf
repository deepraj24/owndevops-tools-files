#For azurerm_virtual_network creation
resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]

  depends_on = [
      azurerm_resource_group.terragrp
  ]
}

/*
#(1. One way to create SUBNETS)

resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.0.0/24"
  }

  subnet {
    name           = "subnetB"
    address_prefix = "10.0.1.0/24"
  }
  depends_on = [
      azurerm_resource_group.terragrp
  ]
}
*/

/*
#(2. Second way to Create SUBNETS. In 2nd method individually define subnets. So,You can use only one method 1st or 2nd
resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]

  depends_on = [
      azurerm_resource_group.terragrp
  ]
}
resource "azurerm_subnet" "subnetA" {
  name                 = local.subnets[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [local.subnets[0].address_prefixes]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}
resource "azurerm_subnet" "subnetB" {
  name                 = local.subnets[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [local.subnets[1].address_prefixes]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}
*/

/*
#Creating only two SUBNETS (In variable.tf file we define the default is 2 so we are using locals.tf files value if default value is 3 or then we can't use locals.tf file)
resource "azurerm_subnet" "subnets" {
  count = var.number_of_sunbnets
  name                 = local.subnets[count.index].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [local.subnets[count.index].address_prefixes]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}
*/

#Creating multiple SUBNETS(Don't use local.tf file line 9 to 19)
resource "azurerm_subnet" "subnets" {
  count = var.number_of_subnets
  name                 = "Subnet${count.index}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = ["10.0.${count.index}.0/24"]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}
#Create Network Security grp for windows VM
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
  count = var.number_of_subnets
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.appnsg.id
  depends_on = [ 
    azurerm_virtual_network.appnetwork,
    azurerm_network_security_group.appnsg
    ]
}
