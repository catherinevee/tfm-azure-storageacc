# Azure Storage Account Module Outputs
# This file contains all output definitions for the Azure Storage Account module

# Storage Account Outputs
output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "The name of the Storage Account."
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_location" {
  description = "The primary location of the Storage Account."
  value       = azurerm_storage_account.main.primary_location
}

output "storage_account_secondary_location" {
  description = "The secondary location of the Storage Account."
  value       = azurerm_storage_account.main.secondary_location
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the Storage Account."
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  description = "The secondary access key for the Storage Account."
  value       = azurerm_storage_account.main.secondary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the Storage Account."
  value       = azurerm_storage_account.main.primary_connection_string
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  description = "The secondary connection string for the Storage Account."
  value       = azurerm_storage_account.main.secondary_connection_string
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "storage_account_secondary_blob_endpoint" {
  description = "The secondary blob endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_blob_endpoint
}

output "storage_account_primary_queue_endpoint" {
  description = "The primary queue endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_queue_endpoint
}

output "storage_account_secondary_queue_endpoint" {
  description = "The secondary queue endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_queue_endpoint
}

output "storage_account_primary_table_endpoint" {
  description = "The primary table endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_table_endpoint
}

output "storage_account_secondary_table_endpoint" {
  description = "The secondary table endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_table_endpoint
}

output "storage_account_primary_file_endpoint" {
  description = "The primary file endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_file_endpoint
}

output "storage_account_secondary_file_endpoint" {
  description = "The secondary file endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_file_endpoint
}

output "storage_account_primary_web_endpoint" {
  description = "The primary web endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_web_endpoint
}

output "storage_account_secondary_web_endpoint" {
  description = "The secondary web endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_web_endpoint
}

output "storage_account_primary_dfs_endpoint" {
  description = "The primary DFS endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_dfs_endpoint
}

output "storage_account_secondary_dfs_endpoint" {
  description = "The secondary DFS endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_dfs_endpoint
}

output "storage_account_primary_ftp_endpoint" {
  description = "The primary FTP endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_ftp_endpoint
}

output "storage_account_secondary_ftp_endpoint" {
  description = "The secondary FTP endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_ftp_endpoint
}

output "storage_account_primary_sftp_endpoint" {
  description = "The primary SFTP endpoint of the Storage Account."
  value       = azurerm_storage_account.main.primary_sftp_endpoint
}

output "storage_account_secondary_sftp_endpoint" {
  description = "The secondary SFTP endpoint of the Storage Account."
  value       = azurerm_storage_account.main.secondary_sftp_endpoint
}

output "storage_account_identity" {
  description = "The identity configuration of the Storage Account."
  value       = azurerm_storage_account.main.identity
}

output "storage_account_network_rules" {
  description = "The network rules configuration of the Storage Account."
  value       = azurerm_storage_account.main.network_rules
}

output "storage_account_blob_properties" {
  description = "The blob properties configuration of the Storage Account."
  value       = azurerm_storage_account.main.blob_properties
}

output "storage_account_queue_properties" {
  description = "The queue properties configuration of the Storage Account."
  value       = azurerm_storage_account.main.queue_properties
}

output "storage_account_share_properties" {
  description = "The share properties configuration of the Storage Account."
  value       = azurerm_storage_account.main.share_properties
}

output "storage_account_static_website" {
  description = "The static website configuration of the Storage Account."
  value       = azurerm_storage_account.main.static_website
}

# Storage Containers Outputs
output "storage_containers" {
  description = "Map of storage containers created."
  value       = azurerm_storage_container.containers
}

output "storage_container_names" {
  description = "List of storage container names."
  value       = keys(azurerm_storage_container.containers)
}

# Storage Queues Outputs
output "storage_queues" {
  description = "Map of storage queues created."
  value       = azurerm_storage_queue.queues
}

output "storage_queue_names" {
  description = "List of storage queue names."
  value       = keys(azurerm_storage_queue.queues)
}

# Storage Tables Outputs
output "storage_tables" {
  description = "Map of storage tables created."
  value       = azurerm_storage_table.tables
}

output "storage_table_names" {
  description = "List of storage table names."
  value       = keys(azurerm_storage_table.tables)
}

# Storage File Shares Outputs
output "storage_file_shares" {
  description = "Map of storage file shares created."
  value       = azurerm_storage_share.file_shares
}

output "storage_file_share_names" {
  description = "List of storage file share names."
  value       = keys(azurerm_storage_share.file_shares)
}

# Storage Account Network Rules Outputs
output "storage_account_network_rules_id" {
  description = "The ID of the Storage Account Network Rules (if created separately)."
  value       = var.create_separate_network_rules ? azurerm_storage_account_network_rules.main[0].id : null
}

# Storage Account Management Policy Outputs
output "storage_account_management_policy_id" {
  description = "The ID of the Storage Account Management Policy."
  value       = var.create_management_policy ? azurerm_storage_management_policy.main[0].id : null
}

# Storage Account Customer Managed Key Outputs
output "storage_account_customer_managed_key_id" {
  description = "The ID of the Storage Account Customer Managed Key."
  value       = var.create_customer_managed_key ? azurerm_storage_account_customer_managed_key.main[0].id : null
}

# Storage Account Local Users Outputs
output "storage_account_local_users" {
  description = "Map of storage account local users created."
  value       = azurerm_storage_account_local_user.local_users
}

output "storage_account_local_user_names" {
  description = "List of storage account local user names."
  value       = keys(azurerm_storage_account_local_user.local_users)
}

# Storage Account Encryption Scopes Outputs
output "storage_account_encryption_scopes" {
  description = "Map of storage account encryption scopes created."
  value       = azurerm_storage_encryption_scope.encryption_scopes
}

output "storage_account_encryption_scope_names" {
  description = "List of storage account encryption scope names."
  value       = keys(azurerm_storage_encryption_scope.encryption_scopes)
}

# Storage Account Data Lake Gen2 Filesystems Outputs
output "storage_account_data_lake_filesystems" {
  description = "Map of storage account data lake filesystems created."
  value       = azurerm_storage_data_lake_gen2_filesystem.data_lake_filesystems
}

output "storage_account_data_lake_filesystem_names" {
  description = "List of storage account data lake filesystem names."
  value       = keys(azurerm_storage_data_lake_gen2_filesystem.data_lake_filesystems)
}

# Storage Account Blob Inventory Policy Outputs
output "storage_account_blob_inventory_policy_id" {
  description = "The ID of the Storage Account Blob Inventory Policy."
  value       = var.create_blob_inventory_policy ? azurerm_storage_blob_inventory_policy.blob_inventory_policy[0].id : null
}

# Comprehensive Storage Account Information
output "storage_account_info" {
  description = "Comprehensive information about the Storage Account."
  value = {
    id                    = azurerm_storage_account.main.id
    name                  = azurerm_storage_account.main.name
    resource_group_name   = azurerm_storage_account.main.resource_group_name
    location              = azurerm_storage_account.main.location
    account_tier          = azurerm_storage_account.main.account_tier
    account_replication_type = azurerm_storage_account.main.account_replication_type
    account_kind          = azurerm_storage_account.main.account_kind
    access_tier           = azurerm_storage_account.main.access_tier
    primary_location      = azurerm_storage_account.main.primary_location
    secondary_location    = azurerm_storage_account.main.secondary_location
    primary_blob_endpoint = azurerm_storage_account.main.primary_blob_endpoint
    primary_queue_endpoint = azurerm_storage_account.main.primary_queue_endpoint
    primary_table_endpoint = azurerm_storage_account.main.primary_table_endpoint
    primary_file_endpoint = azurerm_storage_account.main.primary_file_endpoint
    primary_web_endpoint  = azurerm_storage_account.main.primary_web_endpoint
    primary_dfs_endpoint  = azurerm_storage_account.main.primary_dfs_endpoint
    primary_ftp_endpoint  = azurerm_storage_account.main.primary_ftp_endpoint
    primary_sftp_endpoint = azurerm_storage_account.main.primary_sftp_endpoint
    tags                  = azurerm_storage_account.main.tags
  }
}

# Storage Account Endpoints Summary
output "storage_account_endpoints" {
  description = "Summary of all Storage Account endpoints."
  value = {
    blob = {
      primary   = azurerm_storage_account.main.primary_blob_endpoint
      secondary = azurerm_storage_account.main.secondary_blob_endpoint
    }
    queue = {
      primary   = azurerm_storage_account.main.primary_queue_endpoint
      secondary = azurerm_storage_account.main.secondary_queue_endpoint
    }
    table = {
      primary   = azurerm_storage_account.main.primary_table_endpoint
      secondary = azurerm_storage_account.main.secondary_table_endpoint
    }
    file = {
      primary   = azurerm_storage_account.main.primary_file_endpoint
      secondary = azurerm_storage_account.main.secondary_file_endpoint
    }
    web = {
      primary   = azurerm_storage_account.main.primary_web_endpoint
      secondary = azurerm_storage_account.main.secondary_web_endpoint
    }
    dfs = {
      primary   = azurerm_storage_account.main.primary_dfs_endpoint
      secondary = azurerm_storage_account.main.secondary_dfs_endpoint
    }
    ftp = {
      primary   = azurerm_storage_account.main.primary_ftp_endpoint
      secondary = azurerm_storage_account.main.secondary_ftp_endpoint
    }
    sftp = {
      primary   = azurerm_storage_account.main.primary_sftp_endpoint
      secondary = azurerm_storage_account.main.secondary_sftp_endpoint
    }
  }
}

# Storage Account Security Information
output "storage_account_security_info" {
  description = "Security-related information about the Storage Account."
  value = {
    enable_https_traffic_only = azurerm_storage_account.main.enable_https_traffic_only
    min_tls_version          = azurerm_storage_account.main.min_tls_version
    allow_nested_items_to_be_public = azurerm_storage_account.main.allow_nested_items_to_be_public
    shared_access_key_enabled = azurerm_storage_account.main.shared_access_key_enabled
    public_network_access_enabled = azurerm_storage_account.main.public_network_access_enabled
    default_to_oauth_authentication = azurerm_storage_account.main.default_to_oauth_authentication
    infrastructure_encryption_enabled = azurerm_storage_account.main.infrastructure_encryption_enabled
    identity_type            = azurerm_storage_account.main.identity[0].type
    network_rules_default_action = azurerm_storage_account.main.network_rules[0].default_action
  }
}

# Storage Account Features Information
output "storage_account_features_info" {
  description = "Feature-related information about the Storage Account."
  value = {
    is_hns_enabled            = azurerm_storage_account.main.is_hns_enabled
    nfsv3_enabled             = azurerm_storage_account.main.nfsv3_enabled
    large_file_share_enabled  = azurerm_storage_account.main.large_file_share_enabled
    local_user_enabled        = azurerm_storage_account.main.local_user_enabled
    cross_tenant_replication_enabled = azurerm_storage_account.main.cross_tenant_replication_enabled
    sftp_enabled              = azurerm_storage_account.main.sftp_enabled
    blob_versioning_enabled   = azurerm_storage_account.main.blob_properties[0].versioning_enabled
    blob_change_feed_enabled  = azurerm_storage_account.main.blob_properties[0].change_feed_enabled
    blob_last_access_time_enabled = azurerm_storage_account.main.blob_properties[0].last_access_time_enabled
  }
} 