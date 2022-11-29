
/* #commented out duplicate providers
# provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}
*/


#call the child modules
#define the base_name values

#resoruce 1 child module
#resource group module
module "ResourceGroup" {
  source = "./modules/ResourceGroup"

  base_name = "TerraformExamples02"
  location  = "West US"
}

#resource 2 child module
#storage account module
module "StorageAccount" {
  source = "./modules/StorageAccount"

  base_name           = "TerraformExample02"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = "West US"
}

/*
#resource 3 child module
#virtual network module
module "VirtualNetwork" {
  source = "./modules/VirtualNetwork"

  base_name = "TerraformExample01"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = "West US"
}

#resource 4 child module
#virtual machine module
module "VirtualMachine" {
  source = "./modules/VirtualMachine"

  base_name = "TerraformExample01"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = "West US"
}
*/