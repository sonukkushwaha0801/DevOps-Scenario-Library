variable "environment" {
  description = "The environment for the resources"
  default     = "lab"
}

variable "instance_type" {
  description = "The machine type for the GCP Compute Engine instance"
  type        = map(string)
  default = {
    lab  = "e2-micro"
    dev  = "e2-small"
    prod = "e2-medium"
  }
}

variable "bucket_name" {
  description = "The name of the GCS bucket for Terraform state"
  default     = "tf-lock-lab-state"
}

variable "dynamodb_table_name" {
  description = "The name used for Terraform state locking metadata"
  default     = "tf-lock-lab-locks"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
