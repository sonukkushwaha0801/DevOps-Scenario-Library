resource "vsphere_virtual_machine" "vm" {
  name   = "tf-missing-state-lab"
  cpu    = 2
  memory = 4096
}

