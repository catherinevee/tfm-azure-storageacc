# Advanced Azure Storage Account Example
# This example demonstrates advanced features of the Azure Storage Account module

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-advanced"
  location = "East US"
}

# Create a virtual network for private endpoints
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

# Create a Key Vault for customer managed keys
resource "azurerm_key_vault" "example" {
  name                        = "kv-storage-example"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

# Create a Key Vault key
resource "azurerm_key_vault_key" "example" {
  name         = "storage-encryption-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "encrypt",
    "decrypt",
    "sign",
    "verify",
    "wrapKey",
    "unwrapKey"
  ]
}

# Get current Azure client configuration
data "azurerm_client_config" "current" {}

# Create an advanced storage account
module "storage_account_advanced" {
  source = "../../"

  # Required parameters
  storage_account_name = "stexampleadvanced001"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Advanced configuration
  account_tier             = "Premium"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security and encryption
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled = true
  public_network_access_enabled = false
  default_to_oauth_authentication = true
  infrastructure_encryption_enabled = true

  # Advanced features
  is_hns_enabled            = true
  large_file_share_enabled  = true
  local_user_enabled        = true
  sftp_enabled              = true

  # Identity
  identity_type = "SystemAssigned"

  # Network rules
  network_rules_default_action = "Deny"
  network_rules_bypass         = ["AzureServices"]
  network_rules_ip_rules       = ["203.0.113.0/24"]
  network_rules_virtual_network_subnet_ids = [azurerm_subnet.example.id]

  # Blob properties
  blob_versioning_enabled       = true
  blob_change_feed_enabled      = true
  blob_change_feed_retention_in_days = 30
  blob_last_access_time_enabled = true
  blob_container_delete_retention_days = 7
  blob_delete_retention_days    = 30
  blob_restore_days             = 7

  # Blob CORS
  blob_cors_allowed_headers    = ["*"]
  blob_cors_allowed_methods    = ["GET", "HEAD", "POST", "PUT", "DELETE"]
  blob_cors_allowed_origins    = ["https://example.com"]
  blob_cors_exposed_headers    = ["*"]
  blob_cors_max_age_in_seconds = 86400

  # Queue properties
  queue_logging_delete = true
  queue_logging_read   = true
  queue_logging_write  = true
  queue_logging_retention_policy_days = 7

  queue_minute_metrics_enabled = true
  queue_minute_metrics_include_apis = true
  queue_minute_metrics_retention_policy_days = 7

  queue_hour_metrics_enabled = true
  queue_hour_metrics_include_apis = true
  queue_hour_metrics_retention_policy_days = 7

  # Static website
  static_website_index_document = "index.html"
  static_website_error_404_document = "404.html"

  # Share properties
  share_retention_policy_days = 7
  share_smb_versions = ["SMB3"]
  share_smb_authentication_types = ["NTLMv2", "Kerberos"]
  share_smb_kerberos_ticket_encryption_type = ["AES256"]
  share_smb_channel_encryption_type = ["AES128-CCM", "AES128-GCM", "AES256-GCM"]
  share_smb_multichannel_enabled = true

  # SAS Policy
  sas_policy_expiration_action = "Block"
  sas_policy_expiration_period = "P30D"

  # Customer managed key
  create_customer_managed_key = true
  customer_managed_key_vault_id = azurerm_key_vault.example.id
  customer_managed_key_name = azurerm_key_vault_key.example.name
  customer_managed_key_version = azurerm_key_vault_key.example.version

  # Storage containers
  containers = {
    "data" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "data-storage"
      }
    }
    "logs" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "log-storage"
      }
    }
    "public" = {
      container_access_type = "blob"
      metadata = {
        environment = "production"
        purpose     = "public-content"
      }
    }
  }

  # Storage queues
  queues = {
    "processing-queue" = {
      metadata = {
        environment = "production"
        purpose     = "data-processing"
      }
    }
    "notification-queue" = {
      metadata = {
        environment = "production"
        purpose     = "notifications"
      }
    }
  }

  # Storage tables
  tables = {
    "users" = {
      acl_id        = "user-table-acl"
      acl_permissions = "raud"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
    "sessions" = {
      acl_id        = "session-table-acl"
      acl_permissions = "raud"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
  }

  # File shares
  file_shares = {
    "shared-data" = {
      quota    = 100
      metadata = {
        environment = "production"
        purpose     = "shared-storage"
      }
      acl_id        = "shared-data-acl"
      acl_permissions = "rw"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
  }

  # Local users
  local_users = {
    "admin-user" = {
      home_directory = "/home/admin"
      ssh_authorized_key = {
        description = "Admin SSH key"
        key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
      }
      permission_scope = {
        permissions = {
          read   = true
          write  = true
          delete = true
          list   = true
        }
        service       = "blob"
        resource_name = "data"
      }
      ssh_password_enabled = false
    }
  }

  # Encryption scopes
  encryption_scopes = {
    "sensitive-data" = {
      source           = "Microsoft.KeyVault"
      key_vault_key_id = azurerm_key_vault_key.example.versionless_id
    }
  }

  # Data Lake Gen2 filesystems
  data_lake_filesystems = {
    "analytics" = {
      properties = {
        environment = "production"
        purpose     = "data-analytics"
      }
      ace = {
        permissions = "rwx"
        type        = "user"
        id          = "user-id"
        scope       = "access"
      }
    }
  }

  # Management policy
  create_management_policy = true
  management_policy_rules = [
    {
      name    = "lifecycle-rule"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["data/"]
        match_blob_index_tag = {
          name      = "environment"
          operation = "=="
          value     = "production"
        }
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
    }
  ]

  # Blob inventory policy
  create_blob_inventory_policy = true
  blob_inventory_policy_rules = [
    {
      name = "inventory-rule"
      filter = {
        blob_types        = ["blockBlob"]
        include_blob_versions = true
        include_snapshots     = true
        include_deleted       = false
        prefix_match          = ["data/"]
        exclude_prefixes      = ["data/temp/"]
      }
      format                 = "Csv"
      schedule               = "Daily"
      storage_container_name = "inventory"
    }
  ]

  # Tags
  tags = {
    Environment = "Production"
    Project     = "Advanced Storage Example"
    Owner       = "DevOps Team"
    CostCenter  = "IT-001"
    Compliance  = "SOX"
  }
}

# Output comprehensive information
output "storage_account_info" {
  description = "Comprehensive information about the storage account"
  value       = module.storage_account_advanced.storage_account_info
}

output "storage_account_security_info" {
  description = "Security information about the storage account"
  value       = module.storage_account_advanced.storage_account_security_info
}

output "storage_account_features_info" {
  description = "Features information about the storage account"
  value       = module.storage_account_advanced.storage_account_features_info
}

output "storage_account_endpoints" {
  description = "All storage account endpoints"
  value       = module.storage_account_advanced.storage_account_endpoints
}

output "storage_containers" {
  description = "Created storage containers"
  value       = module.storage_account_advanced.storage_containers
}

output "storage_queues" {
  description = "Created storage queues"
  value       = module.storage_account_advanced.storage_queues
}

output "storage_tables" {
  description = "Created storage tables"
  value       = module.storage_account_advanced.storage_tables
}

output "storage_file_shares" {
  description = "Created storage file shares"
  value       = module.storage_account_advanced.storage_file_shares
}

output "storage_account_local_users" {
  description = "Created local users"
  value       = module.storage_account_advanced.storage_account_local_users
}

output "storage_account_encryption_scopes" {
  description = "Created encryption scopes"
  value       = module.storage_account_advanced.storage_account_encryption_scopes
}

output "storage_account_data_lake_filesystems" {
  description = "Created data lake filesystems"
  value       = module.storage_account_advanced.storage_account_data_lake_filesystems
} 