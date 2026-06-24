resource "null_resource" "network" {}

resource "null_resource" "storage" {}

resource "null_resource" "vm_provisioning" {
  provisioner "local-exec" {
    command = "sleep 600"
  }
}
