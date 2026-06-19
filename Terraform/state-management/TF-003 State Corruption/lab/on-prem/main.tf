
resource "vsphere_virtual_machine" "vm" {
  name   = "tf-state-corruption-lab"
  cpu    = 2
  memory = 4096
}

