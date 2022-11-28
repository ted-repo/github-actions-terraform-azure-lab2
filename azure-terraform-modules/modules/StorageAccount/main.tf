#to generate random values to append the storage account name
#provider for the random 

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

#create a random strong with this parameters
resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_storage_account" "str" {
  name                     = "${lower(var.base_name)}${random_string.random.result}" #concatenating both values
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}


