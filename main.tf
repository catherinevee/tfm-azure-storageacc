# Azure Storage Account Module
# Creates storage account with optional services and security features

# Main storage account resource
# Supports all account types, tiers, and replication options
resource "azurerm_storage_account" "main" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  account_kind              = var.account_kind
  access_tier               = var.access_tier
  edge_zone                 = var.edge_zone
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  shared_access_key_enabled = var.shared_access_key_enabled
  public_network_access_enabled = var.public_network_access_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication
  is_hns_enabled            = var.is_hns_enabled
  nfsv3_enabled             = var.nfsv3_enabled
  large_file_share_enabled  = var.large_file_share_enabled
  local_user_enabled        = var.local_user_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  sftp_enabled              = var.sftp_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  immutability_period_since_creation_in_days = var.immutability_period_since_creation_in_days
  allowed_copy_scope        = var.allowed_copy_scope
  sas_policy {
    expiration_action = var.sas_policy_expiration_action
    expiration_period = var.sas_policy_expiration_period
  }
  custom_domain {
    name          = var.custom_domain_name
    use_subdomain = var.custom_domain_use_subdomain
  }
  customer_managed_key {
    key_vault_key_id          = var.customer_managed_key_vault_key_id
    user_assigned_identity_id = var.customer_managed_user_assigned_identity_id
  }
  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
  blob_properties {
    versioning_enabled       = var.blob_versioning_enabled
    change_feed_enabled      = var.blob_change_feed_enabled
    change_feed_retention_in_days = var.blob_change_feed_retention_in_days
    default_service_version  = var.blob_default_service_version
    last_access_time_enabled = var.blob_last_access_time_enabled
    container_delete_retention_policy {
      days = var.blob_container_delete_retention_days
    }
    delete_retention_policy {
      days = var.blob_delete_retention_days
    }
    restore_policy {
      days = var.blob_restore_days
    }
    cors_rule {
      allowed_headers    = var.blob_cors_allowed_headers
      allowed_methods    = var.blob_cors_allowed_methods
      allowed_origins    = var.blob_cors_allowed_origins
      exposed_headers    = var.blob_cors_exposed_headers
      max_age_in_seconds = var.blob_cors_max_age_in_seconds
    }
  }
  queue_properties {
    cors_rule {
      allowed_headers    = var.queue_cors_allowed_headers
      allowed_methods    = var.queue_cors_allowed_methods
      allowed_origins    = var.queue_cors_allowed_origins
      exposed_headers    = var.queue_cors_exposed_headers
      max_age_in_seconds = var.queue_cors_max_age_in_seconds
    }
    logging {
      delete                = var.queue_logging_delete
      read                  = var.queue_logging_read
      write                 = var.queue_logging_write
      version               = var.queue_logging_version
      retention_policy_days = var.queue_logging_retention_policy_days
    }
    minute_metrics {
      enabled               = var.queue_minute_metrics_enabled
      version               = var.queue_minute_metrics_version
      include_apis          = var.queue_minute_metrics_include_apis
      retention_policy_days = var.queue_minute_metrics_retention_policy_days
    }
    hour_metrics {
      enabled               = var.queue_hour_metrics_enabled
      version               = var.queue_hour_metrics_version
      include_apis          = var.queue_hour_metrics_include_apis
      retention_policy_days = var.queue_hour_metrics_retention_policy_days
    }
  }
  static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
  share_properties {
    cors_rule {
      allowed_headers    = var.share_cors_allowed_headers
      allowed_methods    = var.share_cors_allowed_methods
      allowed_origins    = var.share_cors_allowed_origins
      exposed_headers    = var.share_cors_exposed_headers
      max_age_in_seconds = var.share_cors_max_age_in_seconds
    }
    retention_policy {
      days = var.share_retention_policy_days
    }
    smb {
      versions                        = var.share_smb_versions
      authentication_types            = var.share_smb_authentication_types
      kerberos_ticket_encryption_type = var.share_smb_kerberos_ticket_encryption_type
      channel_encryption_type         = var.share_smb_channel_encryption_type
      multichannel_enabled            = var.share_smb_multichannel_enabled
    }
  }
  routing {
    publish_internet_endpoints  = var.routing_publish_internet_endpoints
    publish_microsoft_endpoints = var.routing_publish_microsoft_endpoints
    choice                       = var.routing_choice
  }
  queue_encryption_key_type = var.queue_encryption_key_type
  table_encryption_key_type  = var.table_encryption_key_type
  tags                      = var.tags
}

# Network rules for access control
# Separate resource to avoid dependency issues during updates
resource "azurerm_storage_account_network_rules" "main" {
  count = var.create_separate_network_rules ? 1 : 0

  storage_account_id         = azurerm_storage_account.main.id
  default_action             = var.network_rules_default_action
  bypass                     = var.network_rules_bypass
  ip_rules                   = var.network_rules_ip_rules
  virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids
  private_link_access {
    endpoint_tenant_id   = var.network_rules_private_link_access_endpoint_tenant_id
    endpoint_resource_id = var.network_rules_private_link_access_endpoint_resource_id
  }
}

# Blob containers for object storage
# Use for unstructured data like images, documents, backups
resource "azurerm_storage_container" "containers" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = each.value.container_access_type
  metadata              = each.value.metadata
}

# Queue storage for message processing
# Good for decoupling services and handling async workloads
resource "azurerm_storage_queue" "queues" {
  for_each = var.queues

  name                 = each.key
  storage_account_name = azurerm_storage_account.main.name
  metadata             = each.value.metadata
}

# Table storage for structured NoSQL data
# Use for key-value pairs and simple query patterns
resource "azurerm_storage_table" "tables" {
  for_each = var.tables

  name                 = each.key
  storage_account_name = azurerm_storage_account.main.name
  acl {
    id = each.value.acl_id
    access_policy {
      permissions = each.value.acl_permissions
      start       = each.value.acl_start
      expiry      = each.value.acl_expiry
    }
  }
}

# File shares for SMB access
# Useful for legacy applications or shared file access
resource "azurerm_storage_share" "file_shares" {
  for_each = var.file_shares

  name                 = each.key
  storage_account_name = azurerm_storage_account.main.name
  quota                = each.value.quota
  metadata             = each.value.metadata
  acl {
    id = each.value.acl_id
    access_policy {
      permissions = each.value.acl_permissions
      start       = each.value.acl_start
      expiry      = each.value.acl_expiry
    }
  }
}

# Lifecycle management policy
# Automates data tiering and cleanup based on age and access patterns
resource "azurerm_storage_management_policy" "main" {
  count = var.create_management_policy ? 1 : 0

  storage_account_id = azurerm_storage_account.main.id

  dynamic "rule" {
    for_each = var.management_policy_rules
    content {
      name    = rule.value.name
      enabled = rule.value.enabled
      filters {
        blob_types   = rule.value.filters.blob_types
        prefix_match = rule.value.filters.prefix_match
      }
      actions {
        base_blob {
          tier_to_cool_after_days_since_modification_greater_than    = rule.value.actions.base_blob.tier_to_cool_after_days_since_modification_greater_than
          tier_to_archive_after_days_since_modification_greater_than = rule.value.actions.base_blob.tier_to_archive_after_days_since_modification_greater_than
          delete_after_days_since_modification_greater_than          = rule.value.actions.base_blob.delete_after_days_since_modification_greater_than
        }
        snapshot {
          tier_to_cool_after_days_since_creation_greater_than    = rule.value.actions.snapshot.tier_to_cool_after_days_since_creation_greater_than
          tier_to_archive_after_days_since_creation_greater_than = rule.value.actions.snapshot.tier_to_archive_after_days_since_creation_greater_than
          delete_after_days_since_creation_greater_than          = rule.value.actions.snapshot.delete_after_days_since_creation_greater_than
        }
        version {
          tier_to_cool_after_days_since_creation_greater_than    = rule.value.actions.version.tier_to_cool_after_days_since_creation_greater_than
          tier_to_archive_after_days_since_creation_greater_than = rule.value.actions.version.tier_to_archive_after_days_since_creation_greater_than
          delete_after_days_since_creation_greater_than          = rule.value.actions.version.delete_after_days_since_creation_greater_than
        }
      }
    }
  }
}

# Customer-managed encryption keys
# Provides control over encryption keys for compliance requirements
resource "azurerm_storage_account_customer_managed_key" "main" {
  count = var.create_customer_managed_key ? 1 : 0

  storage_account_id = azurerm_storage_account.main.id
  key_vault_id       = var.customer_managed_key_vault_id
  key_name           = var.customer_managed_key_name
  key_version        = var.customer_managed_key_version
}

# Local users for SFTP access
# Alternative to Azure AD for specific use cases
resource "azurerm_storage_account_local_user" "local_users" {
  for_each = var.local_users

  name                 = each.key
  storage_account_id   = azurerm_storage_account.main.id
  home_directory       = each.value.home_directory
  ssh_authorized_keys {
    description = each.value.ssh_key_description
    key         = each.value.ssh_key
  }
  ssh_password_enabled = each.value.ssh_password_enabled
  permission_scope {
    permissions {
      read   = each.value.permissions.read
      write  = each.value.permissions.write
      delete = each.value.permissions.delete
      list   = each.value.permissions.list
    }
    resource_name = each.value.resource_name
    service       = each.value.service
  }
  sid = each.value.sid
}

# Encryption scopes for granular control
# Allows different encryption settings per container or blob
resource "azurerm_storage_encryption_scope" "encryption_scopes" {
  for_each = var.encryption_scopes

  name               = each.key
  storage_account_id = azurerm_storage_account.main.id
  source             = each.value.source
  key_vault_key_id   = each.value.key_vault_key_id
}

# Data Lake Gen2 filesystems
# Requires hierarchical namespace enabled on storage account
resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_filesystems" {
  for_each = var.data_lake_filesystems

  name               = each.key
  storage_account_id = azurerm_storage_account.main.id
  properties         = each.value.properties
}

# Blob inventory policy for compliance
# Generates reports for audit and compliance requirements
resource "azurerm_storage_blob_inventory_policy" "blob_inventory_policy" {
  count = var.create_blob_inventory_policy ? 1 : 0

  storage_account_id = azurerm_storage_account.main.id

  dynamic "rules" {
    for_each = var.blob_inventory_policy_rules
    content {
      name     = rules.value.name
      enabled  = rules.value.enabled
      schedule = rules.value.schedule
      storage_container_name = rules.value.storage_container_name
      format   = rules.value.format
      scope    = rules.value.scope
      schema_fields = rules.value.schema_fields
    }
  }
} 