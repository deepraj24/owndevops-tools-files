# Creating Resource grp 
resource "azurerm_resource_group" "terragrp" {
  name     = local.resource_group_name
  location = local.location
}
/*
# Creating Storage account, container and blob

resource "azurerm_storage_account" "terragrpstore" {
  name                     = "terragrpstore"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [
    azurerm_resource_group.terragrp
  ]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "terragrpstore"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.terragrpstore
  ]
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = "terragrpstore"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "main.tf"
  depends_on = [
    azurerm_storage_container.data
  ]
}
*/
#We will find subnet id from 2 different ways
#1. Creating azure network interface
/*
resource "azurerm_network_interface" "appinterface" {
  name                = "appinterface"
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
*/
# In azure interface we define subnet id.Now we Want to see what is the ID of subnetA or subnetB
/*
output "subnetA-id"{
  value=azurerm_subnet.subnetA.id
}
*/

# How to get that subnet id?
#2. we need to access the information about the subnet using virtual interface
/*
resource "azurerm_network_interface" "appinterface" {
  name                = "appinterface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = tolist(azurerm_virtual_network.appnetwork.subnet)[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.appip.id
  }
  depends_on = [
    azurerm_subnet.subnetA
  ]
}

output "subnet-id"{
  value=azurerm_virtual_network.appnetwork.subnet
}

#Creatre public IP
resource "azurerm_public_ip" "appip" {
  name                = "app-ip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.terragrp
  ]
}
*/








