variable "instance_type" {
  description = "Provide VM size according to env."
  type        = map(string)
  default = {
    "test" = "Standard_B2s"
    "lab"  = "Standard_B2ms"
    "prod" = "Standard_D2s_v3"
    "dev"  = "Standard_B1s"
  }
}

variable "ami_id" {
  description = "Provide Azure image reference according to env."
  type        = map(string)
  default = {
    "test" = "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest"
    "lab"  = "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest"
    "prod" = "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest"
    "dev"  = "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest"
  }
}

variable "environment" {
  description = "Provide env name."
  type        = string
  default     = "lab"
}

variable "subscription_id" {
  description = "Provide Azure subscription ID."
  type        = string
}
