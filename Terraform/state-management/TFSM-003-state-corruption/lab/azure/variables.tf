variable "environment" {
  description = "The environment for the resources"
  default     = "lab"
}

variable "instance_type" {
  description = "The VM size for Azure Virtual Machine"
  type        = map(string)
  default = {
    lab  = "Standard_B1s"
    dev  = "Standard_B2s"
    prod = "Standard_B2ms"
  }
}

variable "resource_group_name" {
  description = "The Azure Resource Group name"
  default     = "terraform-rg"
}

variable "storage_account_name" {
  description = "The Azure Storage Account name for Terraform state"
  default     = "tfstatelabstorage"
}

variable "container_name" {
  description = "The Azure Storage Container name for Terraform state"
  default     = "tfstate"
}

variable "location" {
  description = "Azure region"
  default     = "Central India"
}

variable "subscription_id_south" {
  description = "Azure Subscription ID for south environment"
  type        = string
}

variable "subscription_id_east" {
  description = "Azure Subscription ID for east environment"
  type        = string
}
