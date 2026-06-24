provider "google" {
  alias   = "mumbai"
  project = var.project_id
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

provider "google" {
  alias   = "hyderabad"
  project = var.project_id
  region  = "asia-south2"
  zone    = "asia-south2-a"
}
