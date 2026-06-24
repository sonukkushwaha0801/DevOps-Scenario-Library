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

resource "google_compute_subnetwork" "main" {
  name          = "timeout-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.main.id
}

resource "google_compute_firewall" "main" {
  name    = "timeout-firewall"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "null_resource" "gke_simulation" {
  provisioner "local-exec" {
    command = "sleep 600"
  }
}
