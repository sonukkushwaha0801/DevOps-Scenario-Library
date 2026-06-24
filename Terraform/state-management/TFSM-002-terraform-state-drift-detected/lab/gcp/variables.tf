variable "instance_type" {
  description = "Provide machine type according to env."
  type        = map(string)
  default = {
    "test" = "e2-small"
    "lab"  = "e2-medium"
    "prod" = "e2-standard-2"
    "dev"  = "e2-micro"
  }
}

variable "ami_id" {
  description = "Provide GCP image according to env."
  type        = map(string)
  default = {
    "test" = "debian-cloud/debian-11"
    "lab"  = "debian-cloud/debian-11"
    "prod" = "debian-cloud/debian-11"
    "dev"  = "debian-cloud/debian-11"
  }
}

variable "environment" {
  description = "Provide env name."
  type        = string
  default     = "lab"
}

variable "project_id" {
  description = "Provide GCP project ID."
  type        = string
}
