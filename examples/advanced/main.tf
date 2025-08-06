# Advanced Azure Storage Account Example
# Production-ready configuration with comprehensive features

# Resource group for the storage account
resource "azurerm_resource_group" "example" {
  name     = "rg-storage-production"
  location = "East US"
}

# Key Vault for customer-managed keys
resource "azurerm_key_vault" "example" {
  name                       = "kv-storage-keys"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore", "Recover"
    ]
  }
}

# Encryption key for storage account
resource "azurerm_key_vault_key" "storage" {
  name         = "storage-encryption-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

# Production storage account with advanced features
module "storage_account" {
  source = "../../"

  # Required parameters
  storage_account_name = "stprodadvanced"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Performance and availability
  account_tier             = "Premium"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security hardening
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled = true
  public_network_access_enabled = false
  default_to_oauth_authentication = true

  # Advanced features
  is_hns_enabled            = true
  large_file_share_enabled  = true
  local_user_enabled        = true
  sftp_enabled              = true
  infrastructure_encryption_enabled = true

  # Network restrictions
  network_rules_default_action = "Deny"
  network_rules_bypass         = ["AzureServices"]
  network_rules_ip_rules       = ["203.0.113.0/24"]
  network_rules_virtual_network_subnet_ids = []

  # Customer-managed encryption
  create_customer_managed_key = true
  customer_managed_key_vault_id = azurerm_key_vault.example.id
  customer_managed_key_name = azurerm_key_vault_key.storage.name
  customer_managed_key_version = azurerm_key_vault_key.storage.version

  # Blob storage configuration
  blob_versioning_enabled = true
  blob_change_feed_enabled = true
  blob_change_feed_retention_in_days = 30
  blob_delete_retention_days = 30
  blob_container_delete_retention_days = 7

  # Storage containers
  containers = {
    "data" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "application-data"
        retention   = "30-days"
      }
    }
    "backups" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "system-backups"
        retention   = "90-days"
      }
    }
    "logs" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "application-logs"
        retention   = "7-days"
      }
    }
  }

  # Queue storage
  queues = {
    "processing" = {
      metadata = {
        environment = "production"
        purpose     = "job-processing"
      }
    }
    "notifications" = {
      metadata = {
        environment = "production"
        purpose     = "system-notifications"
      }
    }
  }

  # Table storage
  tables = {
    "users" = {
      acl_id        = "user-table-acl"
      acl_permissions = "raud"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
  }

  # File shares
  file_shares = {
    "shared" = {
      quota         = 100
      metadata = {
        environment = "production"
        purpose     = "shared-files"
      }
      acl_id        = "shared-files-acl"
      acl_permissions = "raud"
      acl_start     = "2024-01-01T00:00:00Z"
      acl_expiry    = "2025-01-01T00:00:00Z"
    }
  }

  # Local users for SFTP
  local_users = {
    "sftp-user" = {
      home_directory = "/data"
      ssh_key_description = "Production SFTP key"
      ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
      ssh_password_enabled = false
      permissions = {
        read   = true
        write  = true
        delete = false
        list   = true
      }
      resource_name = "data"
      service       = "blob"
      sid           = "S-1-1-0"
    }
  }

  # Data Lake filesystems
  data_lake_filesystems = {
    "analytics" = {
      properties = {
        environment = "production"
        purpose     = "data-analytics"
      }
    }
  }

  # Lifecycle management
  create_management_policy = true
  management_policy_rules = [
    {
      name    = "data-lifecycle"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["data/"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days_since_modification_greater_than    = 30
          tier_to_archive_after_days_since_modification_greater_than = 90
          delete_after_days_since_modification_greater_than          = 365
        }
        snapshot = {
          tier_to_cool_after_days_since_creation_greater_than    = 30
          tier_to_archive_after_days_since_creation_greater_than = 90
          delete_after_days_since_creation_greater_than          = 365
        }
        version = {
          tier_to_cool_after_days_since_creation_greater_than    = 30
          tier_to_archive_after_days_since_creation_greater_than = 90
          delete_after_days_since_creation_greater_than          = 365
        }
      }
    }
  ]

  # Blob inventory policy
  create_blob_inventory_policy = true
  blob_inventory_policy_rules = [
    {
      name                    = "weekly-inventory"
      enabled                 = true
      schedule                = "Weekly"
      storage_container_name  = "inventory"
      format                  = "Csv"
      scope                   = "Blob"
      schema_fields           = ["Name", "Creation-Time", "Last-Modified", "Content-Length", "Content-Type"]
    }
  ]

  # Resource tags
  tags = {
    Environment = "Production"
    Project     = "Advanced Storage Example"
    Owner       = "DevOps Team"
    CostCenter  = "IT-001"
    Compliance  = "SOX"
  }
}

# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}

# Outputs for application configuration
output "storage_account_name" {
  description = "Storage account name for application configuration"
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Blob endpoint for application access"
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

output "storage_account_primary_dfs_endpoint" {
  description = "Data Lake endpoint for analytics"
  value       = module.storage_account.storage_account_primary_dfs_endpoint
}

output "container_names" {
  description = "List of created container names"
  value       = module.storage_account.storage_container_names
}

output "queue_names" {
  description = "List of created queue names"
  value       = module.storage_account.storage_queue_names
}

output "file_share_names" {
  description = "List of created file share names"
  value       = module.storage_account.storage_file_share_names
}

output "data_lake_filesystem_names" {
  description = "List of created Data Lake filesystem names"
  value       = module.storage_account.storage_account_data_lake_filesystem_names
} 