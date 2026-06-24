resource "google_compute_instance" "name" {
  provider     = google.south-1
  name         = "terraform-drift-detected"
  machine_type = lookup(var.instance_type, var.environment, "e2-micro")
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = var.ami_id[var.environment]
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  labels = {
    name = "terraform-drift-detected"
  }
}
