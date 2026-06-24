provider "google" {
  alias   = "south-1"
  project = var.project_id
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

provider "google" {
  alias   = "us-east-1"
  project = var.project_id
  region  = "us-east1"
  zone    = "us-east1-b"
}
