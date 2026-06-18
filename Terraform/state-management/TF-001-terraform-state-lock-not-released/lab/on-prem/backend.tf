
terraform {
  backend "consul" {
    address = "<backend-address>"
    path    = "terraform/state"
  }
}
