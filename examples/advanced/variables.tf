# Advanced Example Variables
# This file contains variables for the advanced Azure Storage Account example

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-storage-advanced"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "stexampleadvanced001"
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default     = "kv-storage-example"
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-storage-example"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "snet-private-endpoints"
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
  default     = "production"
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be one of: dev, staging, production."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "Advanced Storage Example"
    Owner       = "DevOps Team"
    CostCenter  = "IT-001"
    Compliance  = "SOX"
  }
} 