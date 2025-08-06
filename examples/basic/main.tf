# Basic Azure Storage Account Example
# Minimal configuration for development and testing

# Resource group for the storage account
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-example"
  location = "East US"
}

# Basic storage account with minimal configuration
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplebasic"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Default security settings
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  public_network_access_enabled = true

  # Basic storage containers
  containers = {
    "data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "example-data"
      }
    }
    "logs" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "application-logs"
      }
    }
  }

  # Resource tags
  tags = {
    Environment = "Development"
    Project     = "Storage Example"
    Owner       = "DevOps Team"
  }
}

# Output the storage account information
output "storage_account_name" {
  description = "Storage account name for application configuration"
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Blob endpoint for application access"
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

output "container_names" {
  description = "List of created container names"
  value       = module.storage_account.storage_container_names
} 