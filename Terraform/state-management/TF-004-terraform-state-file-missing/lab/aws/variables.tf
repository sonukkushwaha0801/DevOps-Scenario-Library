
variable "environment" {
  description = "The environment for the resources"
  default     = "lab"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = map(string)
  default = {
    lab  = "t3.micro"
    dev  = "t3.small"
    prod = "t3.medium"
  }
}


variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  default     = "tf-lock-lab-state"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  default     = "tf-lock-lab-locks"
}
