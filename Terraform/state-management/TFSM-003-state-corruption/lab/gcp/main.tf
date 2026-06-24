resource "google_storage_bucket" "terraform_state" {
  provider = google.south-1
  name     = var.bucket_name
  location = "ASIA-SOUTH1"

  versioning {
    enabled = true
  }
}

resource "google_firestore_database" "terraform_locks" {
  name        = var.dynamodb_table_name
  location_id = "asia-south1"
  type        = "FIRESTORE_NATIVE"
}

resource "google_compute_instance" "example" {
  provider     = google.south-1
  name         = var.environment
  machine_type = lookup(var.instance_type, var.environment, "e2-micro")
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  labels = {
    name = var.environment
  }
}
