resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.base_name}" #adding -rg as a suffix
  location = var.location
}