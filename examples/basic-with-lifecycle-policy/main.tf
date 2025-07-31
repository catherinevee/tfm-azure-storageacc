# Basic Azure Storage Account Example with Lifecycle Policy
# This example demonstrates basic storage account creation with lifecycle management

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-lifecycle"
  location = "East US"
}

# Create a storage account with lifecycle policy
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplelifecycle001"
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

  # Blob properties for lifecycle management
  blob_versioning_enabled       = true
  blob_change_feed_enabled      = true
  blob_change_feed_retention_in_days = 30
  blob_last_access_time_enabled = true
  blob_container_delete_retention_days = 7
  blob_delete_retention_days    = 30
  blob_restore_days             = 7

  # Storage containers
  containers = {
    "hot-data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "hot-data"
        tier        = "hot"
      }
    }
    "cool-data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "cool-data"
        tier        = "cool"
      }
    }
    "archive-data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "archive-data"
        tier        = "archive"
      }
    }
  }

  # Lifecycle management policy
  create_management_policy = true
  management_policy_rules = [
    {
      name    = "hot-to-cool"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["hot-data/"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days_since_modification_greater_than    = 30
          tier_to_archive_after_days_since_modification_greater_than = 90
          delete_after_days_since_modification_greater_than          = 365
          auto_tier_to_hot_from_cool_enabled                         = true
        }
        snapshot = {
          delete_after_days_since_creation_greater_than = 30
          tier_to_cool_after_days_since_creation_greater_than    = 30
          tier_to_archive_after_days_since_creation_greater_than = 90
        }
        version = {
          delete_after_days_since_creation = 30
          tier_to_cool_after_days_since_creation    = 30
          tier_to_archive_after_days_since_creation = 90
        }
      }
    },
    {
      name    = "cool-to-archive"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["cool-data/"]
      }
      actions = {
        base_blob = {
          tier_to_archive_after_days_since_modification_greater_than = 60
          delete_after_days_since_modification_greater_than          = 730
        }
        snapshot = {
          delete_after_days_since_creation_greater_than = 60
          tier_to_archive_after_days_since_creation_greater_than = 60
        }
        version = {
          delete_after_days_since_creation = 60
          tier_to_archive_after_days_since_creation = 60
        }
      }
    },
    {
      name    = "archive-cleanup"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["archive-data/"]
      }
      actions = {
        base_blob = {
          delete_after_days_since_modification_greater_than = 2555
        }
        snapshot = {
          delete_after_days_since_creation_greater_than = 2555
        }
        version = {
          delete_after_days_since_creation = 2555
        }
      }
    }
  ]

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Lifecycle Policy Example"
    Owner       = "DevOps Team"
    Purpose     = "Data Lifecycle Management"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_account_management_policy_id" {
  description = "Management policy ID"
  value       = module.storage_account.storage_account_management_policy_id
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account.storage_containers
}

output "storage_account_blob_properties" {
  description = "Blob properties configuration"
  value       = module.storage_account.storage_account_blob_properties
} 