resource "azurerm_resource_group" "india" {
  name     = "rg-india"
  location = "Central India"
}

resource "azurerm_resource_group" "us" {
  name     = "rg-us"
  location = "East US"
}
