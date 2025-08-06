# Azure Storage Account Module Outputs
# Essential information for consuming modules and applications

# Storage Account Information
output "storage_account_id" {
  description = "Storage account resource ID for dependency management"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "Storage account name for application configuration"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_location" {
  description = "Primary region for data residency compliance"
  value       = azurerm_storage_account.main.primary_location
}

output "storage_account_secondary_location" {
  description = "Secondary region for disaster recovery"
  value       = azurerm_storage_account.main.secondary_location
}

output "storage_account_primary_access_key" {
  description = "Primary access key for application authentication (sensitive)"
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  description = "Secondary access key for failover scenarios (sensitive)"
  value       = azurerm_storage_account.main.secondary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "Primary connection string for SDK integration (sensitive)"
  value       = azurerm_storage_account.main.primary_connection_string
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  description = "Secondary connection string for failover (sensitive)"
  value       = azurerm_storage_account.main.secondary_connection_string
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  description = "Blob service endpoint for object storage access"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "storage_account_secondary_blob_endpoint" {
  description = "Secondary blob endpoint for failover"
  value       = azurerm_storage_account.main.secondary_blob_endpoint
}

output "storage_account_primary_queue_endpoint" {
  description = "Queue service endpoint for message processing"
  value       = azurerm_storage_account.main.primary_queue_endpoint
}

output "storage_account_secondary_queue_endpoint" {
  description = "Secondary queue endpoint for failover"
  value       = azurerm_storage_account.main.secondary_queue_endpoint
}

output "storage_account_primary_table_endpoint" {
  description = "Table service endpoint for NoSQL data access"
  value       = azurerm_storage_account.main.primary_table_endpoint
}

output "storage_account_secondary_table_endpoint" {
  description = "Secondary table endpoint for failover"
  value       = azurerm_storage_account.main.secondary_table_endpoint
}

output "storage_account_primary_file_endpoint" {
  description = "File service endpoint for SMB file access"
  value       = azurerm_storage_account.main.primary_file_endpoint
}

output "storage_account_secondary_file_endpoint" {
  description = "Secondary file endpoint for failover"
  value       = azurerm_storage_account.main.secondary_file_endpoint
}

output "storage_account_primary_web_endpoint" {
  description = "Static website endpoint for web hosting"
  value       = azurerm_storage_account.main.primary_web_endpoint
}

output "storage_account_secondary_web_endpoint" {
  description = "Secondary web endpoint for failover"
  value       = azurerm_storage_account.main.secondary_web_endpoint
}

output "storage_account_primary_dfs_endpoint" {
  description = "Data Lake Gen2 endpoint for big data workloads"
  value       = azurerm_storage_account.main.primary_dfs_endpoint
}

output "storage_account_secondary_dfs_endpoint" {
  description = "Secondary Data Lake endpoint for failover"
  value       = azurerm_storage_account.main.secondary_dfs_endpoint
}

output "storage_account_primary_ftp_endpoint" {
  description = "FTP endpoint for legacy file transfer"
  value       = azurerm_storage_account.main.primary_ftp_endpoint
}

output "storage_account_secondary_ftp_endpoint" {
  description = "Secondary FTP endpoint for failover"
  value       = azurerm_storage_account.main.secondary_ftp_endpoint
}

output "storage_account_primary_sftp_endpoint" {
  description = "SFTP endpoint for secure file transfer"
  value       = azurerm_storage_account.main.primary_sftp_endpoint
}

output "storage_account_secondary_sftp_endpoint" {
  description = "Secondary SFTP endpoint for failover"
  value       = azurerm_storage_account.main.secondary_sftp_endpoint
}

output "storage_account_identity" {
  description = "Managed identity configuration for secure access"
  value       = azurerm_storage_account.main.identity
}

output "storage_account_network_rules" {
  description = "Network rules configuration for access control"
  value       = azurerm_storage_account.main.network_rules
}

output "storage_account_blob_properties" {
  description = "Blob service properties for versioning and retention"
  value       = azurerm_storage_account.main.blob_properties
}

output "storage_account_queue_properties" {
  description = "Queue service properties for logging and metrics"
  value       = azurerm_storage_account.main.queue_properties
}

output "storage_account_share_properties" {
  description = "File share properties for SMB configuration"
  value       = azurerm_storage_account.main.share_properties
}

output "storage_account_static_website" {
  description = "Static website configuration for web hosting"
  value       = azurerm_storage_account.main.static_website
}

# Storage Services Outputs
output "storage_containers" {
  description = "Created blob containers with access types and metadata"
  value       = azurerm_storage_container.containers
}

output "storage_container_names" {
  description = "List of created container names for easy reference"
  value       = keys(azurerm_storage_container.containers)
}

output "storage_queues" {
  description = "Created queue storage with metadata"
  value       = azurerm_storage_queue.queues
}

output "storage_queue_names" {
  description = "List of created queue names for easy reference"
  value       = keys(azurerm_storage_queue.queues)
}

output "storage_tables" {
  description = "Created table storage with ACL configuration"
  value       = azurerm_storage_table.tables
}

output "storage_table_names" {
  description = "List of created table names for easy reference"
  value       = keys(azurerm_storage_table.tables)
}

output "storage_file_shares" {
  description = "Created file shares with quota and ACL configuration"
  value       = azurerm_storage_share.file_shares
}

output "storage_file_share_names" {
  description = "List of created file share names for easy reference"
  value       = keys(azurerm_storage_share.file_shares)
}

# Network and Security Outputs
output "storage_account_network_rules_id" {
  description = "Network rules resource ID for dependency management"
  value       = var.create_separate_network_rules ? azurerm_storage_account_network_rules.main[0].id : null
}

output "storage_account_management_policy_id" {
  description = "Lifecycle management policy ID for monitoring"
  value       = var.create_management_policy ? azurerm_storage_management_policy.main[0].id : null
}

output "storage_account_customer_managed_key_id" {
  description = "Customer-managed key configuration ID for compliance"
  value       = var.create_customer_managed_key ? azurerm_storage_account_customer_managed_key.main[0].id : null
}

# Local Users and Advanced Features
output "storage_account_local_users" {
  description = "Created local users for SFTP access"
  value       = azurerm_storage_account_local_user.local_users
}

output "storage_account_local_user_names" {
  description = "List of created local user names for easy reference"
  value       = keys(azurerm_storage_account_local_user.local_users)
}

output "storage_account_encryption_scopes" {
  description = "Created encryption scopes for granular control"
  value       = azurerm_storage_encryption_scope.encryption_scopes
}

output "storage_account_encryption_scope_names" {
  description = "List of created encryption scope names for easy reference"
  value       = keys(azurerm_storage_encryption_scope.encryption_scopes)
}

output "storage_account_data_lake_filesystems" {
  description = "Created Data Lake Gen2 filesystems"
  value       = azurerm_storage_data_lake_gen2_filesystem.data_lake_filesystems
}

output "storage_account_data_lake_filesystem_names" {
  description = "List of created Data Lake filesystem names for easy reference"
  value       = keys(azurerm_storage_data_lake_gen2_filesystem.data_lake_filesystems)
}

output "storage_account_blob_inventory_policy_id" {
  description = "Blob inventory policy ID for compliance reporting"
  value       = var.create_blob_inventory_policy ? azurerm_storage_blob_inventory_policy.blob_inventory_policy[0].id : null
}

# Comprehensive Information Outputs
output "storage_account_info" {
  description = "Complete storage account information for monitoring and management"
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
    enable_https_traffic_only = azurerm_storage_account.main.enable_https_traffic_only
    min_tls_version       = azurerm_storage_account.main.min_tls_version
    is_hns_enabled        = azurerm_storage_account.main.is_hns_enabled
    large_file_share_enabled = azurerm_storage_account.main.large_file_share_enabled
    local_user_enabled    = azurerm_storage_account.main.local_user_enabled
    sftp_enabled          = azurerm_storage_account.main.sftp_enabled
    infrastructure_encryption_enabled = azurerm_storage_account.main.infrastructure_encryption_enabled
    tags                  = azurerm_storage_account.main.tags
  }
}

output "storage_account_endpoints" {
  description = "All storage account endpoints for application configuration"
  value = {
    primary_blob_endpoint   = azurerm_storage_account.main.primary_blob_endpoint
    secondary_blob_endpoint = azurerm_storage_account.main.secondary_blob_endpoint
    primary_queue_endpoint  = azurerm_storage_account.main.primary_queue_endpoint
    secondary_queue_endpoint = azurerm_storage_account.main.secondary_queue_endpoint
    primary_table_endpoint  = azurerm_storage_account.main.primary_table_endpoint
    secondary_table_endpoint = azurerm_storage_account.main.secondary_table_endpoint
    primary_file_endpoint   = azurerm_storage_account.main.primary_file_endpoint
    secondary_file_endpoint = azurerm_storage_account.main.secondary_file_endpoint
    primary_web_endpoint    = azurerm_storage_account.main.primary_web_endpoint
    secondary_web_endpoint  = azurerm_storage_account.main.secondary_web_endpoint
    primary_dfs_endpoint    = azurerm_storage_account.main.primary_dfs_endpoint
    secondary_dfs_endpoint  = azurerm_storage_account.main.secondary_dfs_endpoint
    primary_ftp_endpoint    = azurerm_storage_account.main.primary_ftp_endpoint
    secondary_ftp_endpoint  = azurerm_storage_account.main.secondary_ftp_endpoint
    primary_sftp_endpoint   = azurerm_storage_account.main.primary_sftp_endpoint
    secondary_sftp_endpoint = azurerm_storage_account.main.secondary_sftp_endpoint
  }
}

output "storage_account_security_info" {
  description = "Security configuration details for compliance and auditing"
  value = {
    enable_https_traffic_only = azurerm_storage_account.main.enable_https_traffic_only
    min_tls_version           = azurerm_storage_account.main.min_tls_version
    allow_nested_items_to_be_public = azurerm_storage_account.main.allow_nested_items_to_be_public
    shared_access_key_enabled = azurerm_storage_account.main.shared_access_key_enabled
    public_network_access_enabled = azurerm_storage_account.main.public_network_access_enabled
    default_to_oauth_authentication = azurerm_storage_account.main.default_to_oauth_authentication
    infrastructure_encryption_enabled = azurerm_storage_account.main.infrastructure_encryption_enabled
    network_rules = azurerm_storage_account.main.network_rules
    identity = azurerm_storage_account.main.identity
  }
}

output "storage_account_features_info" {
  description = "Feature configuration details for monitoring and troubleshooting"
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