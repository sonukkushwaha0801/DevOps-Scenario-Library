terraform {
  backend "s3" {
    provider       = aws.south-1
    bucket         = var.bucket_name
    key            = "terraform.tfstate"
    dynamodb_table = "tf-lock-lab-locks"
    encrypt        = true
  }
}

