# Basic Azure Storage Account Example with Queues
# This example demonstrates basic storage account creation with queues

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-queues"
  location = "East US"
}

# Create a storage account with queues
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplequeues001"
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

  # Storage queues
  queues = {
    "email-queue" = {
      metadata = {
        environment = "development"
        purpose     = "email-notifications"
        priority    = "high"
      }
    }
    "order-processing" = {
      metadata = {
        environment = "development"
        purpose     = "order-processing"
        sla         = "5-minutes"
      }
    }
    "user-registration" = {
      metadata = {
        environment = "development"
        purpose     = "user-registration"
        priority    = "normal"
      }
    }
    "system-events" = {
      metadata = {
        environment = "development"
        purpose     = "system-events"
        retention   = "7-days"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Storage Queues Example"
    Owner       = "DevOps Team"
    Purpose     = "Message Queuing"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_queues" {
  description = "Created storage queues"
  value       = module.storage_account.storage_queues
}

output "storage_queue_names" {
  description = "Names of created storage queues"
  value       = module.storage_account.storage_queue_names
}

output "storage_account_primary_queue_endpoint" {
  description = "Primary queue endpoint"
  value       = module.storage_account.storage_account_primary_queue_endpoint
} 