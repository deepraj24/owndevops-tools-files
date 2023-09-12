locals {
  resource_group_name="terra_grp"
  location="East US"
  virtual_network={
    name="app-network"
    address_space="10.0.0.0/16"
  }
}
/*
  subnets=[
  {
    name="subnetA"
    address_prefixes="10.0.0.0/24"
  },
  {
    name="subnetB"
    address_prefixes="10.0.1.0/24"
  }
  ]
}
*/
