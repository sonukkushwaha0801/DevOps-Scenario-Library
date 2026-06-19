resource "aws_instance" "name" {
  provider      = aws.mumbai
  ami           = var.ami_id[var.environment]
  instance_type = lookup(var.instance_type, var.environment, "t3.micro")

  tags = {
    Name = "Terraform-Drift-Detected"
  }
}
