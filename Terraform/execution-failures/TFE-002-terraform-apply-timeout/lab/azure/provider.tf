provider "azurerm" {
  alias = "mumbai"

  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  alias = "hyderabad"

  features {}
  subscription_id = var.subscription_id
}
