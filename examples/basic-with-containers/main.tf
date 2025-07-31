# Basic Azure Storage Account Example with Containers
# This example demonstrates basic storage account creation with containers

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-containers"
  location = "East US"
}

# Create a storage account with containers
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplecontainers001"
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

  # Storage containers
  containers = {
    "data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "application-data"
        owner       = "dev-team"
      }
    }
    "logs" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "application-logs"
        retention   = "30-days"
      }
    }
    "public-assets" = {
      container_access_type = "blob"
      metadata = {
        environment = "development"
        purpose     = "public-assets"
        cdn-enabled = "true"
      }
    }
    "backups" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "database-backups"
        retention   = "90-days"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Storage Containers Example"
    Owner       = "DevOps Team"
    Purpose     = "Application Storage"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account.storage_containers
}

output "storage_container_names" {
  description = "Names of created storage containers"
  value       = module.storage_account.storage_container_names
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage_account.storage_account_primary_blob_endpoint
} 