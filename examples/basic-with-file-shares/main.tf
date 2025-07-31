# Basic Azure Storage Account Example with File Shares
# This example demonstrates basic storage account creation with file shares

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-files"
  location = "East US"
}

# Create a storage account with file shares
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplefiles001"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Basic configuration
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security settings
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled = true
  public_network_access_enabled = true

  # File shares
  file_shares = {
    "shared-documents" = {
      quota    = 100
      metadata = {
        environment = "development"
        purpose     = "shared-documents"
        department  = "all"
      }
      acl_id        = "shared-docs-acl"
      acl_permissions = "rw"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
    "user-profiles" = {
      quota    = 50
      metadata = {
        environment = "development"
        purpose     = "user-profiles"
        department  = "hr"
      }
      acl_id        = "user-profiles-acl"
      acl_permissions = "rw"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
    "backup-storage" = {
      quota    = 200
      metadata = {
        environment = "development"
        purpose     = "backup-storage"
        retention   = "30-days"
      }
      acl_id        = "backup-acl"
      acl_permissions = "rw"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Storage File Shares Example"
    Owner       = "DevOps Team"
    Purpose     = "File Storage"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_file_shares" {
  description = "Created storage file shares"
  value       = module.storage_account.storage_file_shares
}

output "storage_file_share_names" {
  description = "Names of created storage file shares"
  value       = module.storage_account.storage_file_share_names
}

output "storage_account_primary_file_endpoint" {
  description = "Primary file endpoint"
  value       = module.storage_account.storage_account_primary_file_endpoint
} 