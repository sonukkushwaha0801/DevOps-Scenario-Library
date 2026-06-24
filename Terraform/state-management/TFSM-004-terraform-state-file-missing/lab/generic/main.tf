resource "null_resource" "example" {
  triggers = {
    environment = "lab"
  }
}

