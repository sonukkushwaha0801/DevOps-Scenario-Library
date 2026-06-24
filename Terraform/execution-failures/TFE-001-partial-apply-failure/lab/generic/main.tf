
resource "null_resource" "success_1" {}

resource "null_resource" "success_2" {}

resource "null_resource" "failure" {
  provisioner "local-exec" {
    command = "exit 1"
  }
}
