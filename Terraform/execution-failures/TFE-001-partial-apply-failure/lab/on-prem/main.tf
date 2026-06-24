
resource "null_resource" "network" {}

resource "null_resource" "storage" {}

resource "null_resource" "vm_failure" {
  provisioner "local-exec" {
    command = "exit 1"
  }
}
