variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "lab"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "Central India"
}

variable "vm_size" {
  description = "VM size for Azure Linux Virtual Machine"
  type        = map(string)

  default = {
    lab  = "Standard_B1s"
    dev  = "Standard_B2s"
    prod = "Standard_B2ms"
  }
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-lab"
}

variable "storage_account_name" {
  description = "Storage account for Terraform state"
  type        = string
  default     = "tfstatelab001"
}

variable "container_name" {
  description = "Blob container name for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "public_ssh_key" {
  description = "SSH public key for VM access"
  type        = string
}
