provider "azurerm" {
  alias = "south"
  features {}
  subscription_id = var.subscription_id_south
}

provider "azurerm" {
  alias = "east"
  features {}
  subscription_id = var.subscription_id_east
}
