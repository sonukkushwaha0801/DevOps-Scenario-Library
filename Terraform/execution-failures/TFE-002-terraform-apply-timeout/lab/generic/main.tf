resource "null_resource" "resource_1" {}

resource "null_resource" "resource_2" {}

resource "null_resource" "long_running" {
  provisioner "local-exec" {
    command = "sleep 600"
  }
}

