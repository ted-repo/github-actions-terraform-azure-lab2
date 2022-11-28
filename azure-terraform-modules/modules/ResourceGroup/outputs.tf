#this will allow us to pass the name of the resource group into the storage account module

output "rg_name_out" {
  value = azurerm_resource_group.rg.name
}