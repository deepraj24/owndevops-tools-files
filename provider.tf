terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.62.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "0365254b-6948-4bf5-b1a5-a8cd02921bde"
  tenant_id = "66afd135-b031-4b22-80b2-f59ebbefa21b"
  client_id = "829fa984-48c3-4108-ac77-e8a847d794fc"
  client_secret = "q~L8Q~dSMNLrl3HH2q6zLhnj.El.cYuqsTDCibxN"
  features {}
}