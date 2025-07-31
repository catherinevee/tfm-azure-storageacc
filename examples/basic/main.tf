# Basic Azure Storage Account Example
# This example demonstrates the basic usage of the Azure Storage Account module

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-example"
  location = "East US"
}

# Create a basic storage account
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplebasic001"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Optional parameters with default values
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

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Storage Example"
    Owner       = "DevOps Team"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_account_endpoints" {
  description = "Storage account endpoints"
  value       = module.storage_account.storage_account_endpoints
}

output "storage_account_primary_access_key" {
  description = "Primary access key (sensitive)"
  value       = module.storage_account.storage_account_primary_access_key
  sensitive   = true
} 