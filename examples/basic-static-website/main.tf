# Basic Azure Storage Account Example with Static Website
# This example demonstrates basic storage account creation with static website hosting

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-static-website"
  location = "East US"
}

# Create a storage account with static website hosting
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplestatic001"
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

  # Static website configuration
  static_website_index_document = "index.html"
  static_website_error_404_document = "404.html"

  # Storage containers for static website
  containers = {
    "$web" = {
      container_access_type = "blob"
      metadata = {
        environment = "development"
        purpose     = "static-website"
        cdn-enabled = "true"
      }
    }
    "assets" = {
      container_access_type = "blob"
      metadata = {
        environment = "development"
        purpose     = "static-assets"
        cache-control = "max-age=31536000"
      }
    }
    "images" = {
      container_access_type = "blob"
      metadata = {
        environment = "development"
        purpose     = "static-images"
        cache-control = "max-age=86400"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Static Website Example"
    Owner       = "DevOps Team"
    Purpose     = "Static Website Hosting"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_account_static_website" {
  description = "Static website configuration"
  value       = module.storage_account.storage_account_static_website
}

output "storage_account_primary_web_endpoint" {
  description = "Primary web endpoint for static website"
  value       = module.storage_account.storage_account_primary_web_endpoint
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account.storage_containers
} 