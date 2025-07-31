# Basic Azure Storage Account Example with Network Rules
# This example demonstrates basic storage account creation with network security rules

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-network-rules"
  location = "East US"
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = "vnet-storage-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet for private endpoints
resource "azurerm_subnet" "example" {
  name                 = "snet-private-endpoints"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a storage account with network rules
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexamplenetwork001"
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
  public_network_access_enabled = false
  default_to_oauth_authentication = true

  # Network rules
  network_rules_default_action = "Deny"
  network_rules_bypass         = ["AzureServices"]
  network_rules_ip_rules       = ["203.0.113.0/24", "198.51.100.0/24"]
  network_rules_virtual_network_subnet_ids = [azurerm_subnet.example.id]

  # Storage containers
  containers = {
    "secure-data" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "secure-data"
        security    = "high"
      }
    }
    "internal-docs" = {
      container_access_type = "private"
      metadata = {
        environment = "development"
        purpose     = "internal-docs"
        access      = "vnet-only"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "Network Rules Example"
    Owner       = "DevOps Team"
    Purpose     = "Secure Storage"
    Security    = "High"
  }
}

# Output the storage account information
output "storage_account_info" {
  description = "Information about the created storage account"
  value       = module.storage_account.storage_account_info
}

output "storage_account_security_info" {
  description = "Security information about the storage account"
  value       = module.storage_account.storage_account_security_info
}

output "storage_account_network_rules" {
  description = "Network rules configuration"
  value       = module.storage_account.storage_account_network_rules
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account.storage_containers
}

output "virtual_network_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.example.id
}

output "subnet_id" {
  description = "Subnet ID for private endpoints"
  value       = azurerm_subnet.example.id
} 