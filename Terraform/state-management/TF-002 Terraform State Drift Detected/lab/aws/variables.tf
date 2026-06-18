variable "instance_type" {
  description = "Provide Instance_type according to env."
  type        = map(string)
  default = {
    "test" = "t3.small"
    "lab"  = "t3.medium"
    "prod" = "t3.large"
    "dev"  = "t2.micro"
  }
}

variable "ami_id" {
  description = "Provide AMI ID according to env."
  type        = map(string)
  default = {
    "test" = "ami-0c55b159cbfafe1f0"
    "lab"  = "ami-0c55b159cbfafe1f0"
    "prod" = "ami-0c55b159cbfafe1f0"
    "dev"  = "ami-0c55b159cbfafe1f0"
  }
}

variable "environment" {
  description = "Provide env name."
  type        = string
  default     = "lab"
}
