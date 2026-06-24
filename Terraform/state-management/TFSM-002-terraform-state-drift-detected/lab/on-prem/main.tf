
resource "vsphere_virtual_machine" "vm" {
  name   = "tf-drift-lab"
  cpu    = 2
  memory = 4096
}

