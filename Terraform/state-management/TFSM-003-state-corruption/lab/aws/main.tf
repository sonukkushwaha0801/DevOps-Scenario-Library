
resource "aws_s3_bucket" "terraform_state" {
  provider = aws.south-1
  bucket   = var.bucket_name
}

resource "aws_dynamodb_table" "terraform_locks" {
  provider     = aws.south-1
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_instance" "example" {
  provider      = aws.south-1
  instance_type = lookup(var.instance_type, var.environment, "t3.micro")
  ami           = "ami-0c55b159cbfafe1f0"
  tags = {
    Name = var.environment
  }

}

