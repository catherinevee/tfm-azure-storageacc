# Basic Azure Storage Account Example - Premium Tier
# This example demonstrates basic storage account creation with Premium tier

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-premium"
  location = "East US"
}

# Create a Premium storage account
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplepremium001"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Premium configuration
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security settings
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled = true
  public_network_access_enabled = true

  # Advanced features for Premium tier
  large_file_share_enabled = true
  infrastructure_encryption_enabled = true

  # Blob properties optimized for Premium
  blob_versioning_enabled       = true
  blob_change_feed_enabled      = true
  blob_change_feed_retention_in_days = 30
  blob_last_access_time_enabled = true
  blob_container_delete_retention_days = 7
  blob_delete_retention_days    = 30
  blob_restore_days             = 7

  # Storage containers for high-performance workloads
  containers = {
    "high-performance-data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "high-performance-data"
        tier        = "premium"
        performance = "high"
      }
    }
    "database-backups" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "database-backups"
        tier        = "premium"
        backup-type = "full"
      }
    }
    "transaction-logs" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "transaction-logs"
        tier        = "premium"
        log-type    = "transaction"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Premium Storage Example"
    Owner       = "DevOps Team"
    Purpose     = "High Performance Storage"
    Tier        = "Premium"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_account_features_info" {
  description = "Features information about the storage account"
  value       = module.storage_account.storage_account_features_info
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account.storage_containers
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

output "storage_account_blob_properties" {
  description = "Blob properties configuration"
  value       = module.storage_account.storage_account_blob_properties
} 