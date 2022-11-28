##################################################################################
# TERRAFORM CONFIG
##################################################################################

######## updating the provider to 0.13+ ##############
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.32.0"
        }
    }
    backend "azurerm" {
        key = "rgstr.terraform.tfstate"
    }
}


##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  features {}
}