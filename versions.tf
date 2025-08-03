# Azure Storage Account Module - Version Constraints
# This file defines the required Terraform and provider versions

terraform {
  required_version = "~> 1.13.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38.1"
    }
  }
} 