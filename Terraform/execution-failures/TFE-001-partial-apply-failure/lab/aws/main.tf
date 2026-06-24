resource "aws_instance" "name" {
  provider      = aws.mumbai
  ami           = var.ami_id[var.environment]
  instance_type = lookup(var.instance_type, var.environment, "t3.micro")

  tags = {
    Name = "Terraform-Drift-Detected"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name   = "partial-apply-sg"
}
