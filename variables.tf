# Azure Storage Account Module Variables
# Core configuration for storage account deployment

# Required Variables
variable "storage_account_name" {
  description = "Storage account name (3-24 chars, globally unique across Azure)"
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters in length."
  }
}

variable "resource_group_name" {
  description = "Resource group where storage account will be created"
  type        = string
}

variable "location" {
  description = "Azure region for storage account deployment"
  type        = string
}

# Storage Account Configuration
variable "account_tier" {
  description = "Performance tier - Standard for general use, Premium for high-performance workloads"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "Data replication strategy - LRS for cost, GRS for availability, ZRS for performance"
  type        = string
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Account replication type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "account_kind" {
  description = "Account type - StorageV2 for general use, specialized types for specific workloads"
  type        = string
  default     = "StorageV2"
  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Account kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "access_tier" {
  description = "Data access tier - Hot for frequent access, Cool for cost optimization"
  type        = string
  default     = "Hot"
  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Access tier must be either 'Hot' or 'Cool'."
  }
}

variable "edge_zone" {
  description = "Edge zone for low-latency access in specific regions"
  type        = string
  default     = null
}

# Security and Network Configuration
variable "enable_https_traffic_only" {
  description = "Force HTTPS traffic for all storage operations"
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version - TLS1_2 recommended for security"
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Minimum TLS version must be one of: TLS1_0, TLS1_1, TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow containers and blobs to be publicly accessible"
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Enable shared key authentication for legacy applications"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Allow public network access to storage account"
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure AD authentication in Azure portal"
  type        = bool
  default     = false
}

# Advanced Features
variable "is_hns_enabled" {
  description = "Enable hierarchical namespace for Data Lake Gen2 features"
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Enable NFSv3 protocol for Linux file system compatibility"
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Enable large file shares for big data workloads"
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "Enable local users for SFTP access without Azure AD"
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Enable cross-tenant replication for multi-tenant scenarios"
  type        = bool
  default     = false
}

variable "sftp_enabled" {
  description = "Enable SFTP for secure file transfer operations"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Enable double encryption at infrastructure level"
  type        = bool
  default     = false
}

variable "immutability_period_since_creation_in_days" {
  description = "Days to prevent data modification for compliance"
  type        = number
  default     = null
}

variable "allowed_copy_scope" {
  description = "Allowed copy scope for cross-region replication"
  type        = string
  default     = null
  validation {
    condition     = var.allowed_copy_scope == null || contains(["PrivateLink", "AAD"], var.allowed_copy_scope)
    error_message = "Allowed copy scope must be either 'PrivateLink' or 'AAD'."
  }
}

# SAS Policy Configuration
variable "sas_policy_expiration_action" {
  description = "Action when SAS token expires - Log or Delete"
  type        = string
  default     = "Log"
  validation {
    condition     = contains(["Log", "Delete"], var.sas_policy_expiration_action)
    error_message = "SAS policy expiration action must be either 'Log' or 'Delete'."
  }
}

variable "sas_policy_expiration_period" {
  description = "SAS token expiration period in ISO 8601 format"
  type        = string
  default     = "P1D"
}

# Custom Domain Configuration
variable "custom_domain_name" {
  description = "Custom domain name for storage account access"
  type        = string
  default     = null
}

variable "custom_domain_use_subdomain" {
  description = "Use subdomain for custom domain access"
  type        = bool
  default     = false
}

# Customer Managed Key Configuration
variable "customer_managed_key_vault_key_id" {
  description = "Key Vault key ID for customer-managed encryption"
  type        = string
  default     = null
}

variable "customer_managed_user_assigned_identity_id" {
  description = "User-assigned identity ID for key access"
  type        = string
  default     = null
}

# Identity Configuration
variable "identity_type" {
  description = "Managed identity type - SystemAssigned or UserAssigned"
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned,UserAssigned"], var.identity_type)
    error_message = "Identity type must be one of: SystemAssigned, UserAssigned, SystemAssigned,UserAssigned."
  }
}

variable "identity_ids" {
  description = "User-assigned identity IDs when using UserAssigned identity"
  type        = list(string)
  default     = null
}

# Blob Properties Configuration
variable "blob_versioning_enabled" {
  description = "Enable blob versioning for data protection"
  type        = bool
  default     = false
}

variable "blob_change_feed_enabled" {
  description = "Enable change feed for audit trails"
  type        = bool
  default     = false
}

variable "blob_change_feed_retention_in_days" {
  description = "Days to retain change feed data"
  type        = number
  default     = null
}

variable "blob_default_service_version" {
  description = "Default API version for blob operations"
  type        = string
  default     = null
}

variable "blob_last_access_time_enabled" {
  description = "Track last access time for analytics"
  type        = bool
  default     = false
}

variable "blob_container_delete_retention_days" {
  description = "Days to retain deleted containers"
  type        = number
  default     = null
}

variable "blob_delete_retention_days" {
  description = "Days to retain deleted blobs"
  type        = number
  default     = null
}

variable "blob_restore_days" {
  description = "Days to retain data for point-in-time restore"
  type        = number
  default     = null
}

# CORS Configuration for Blob Storage
variable "blob_cors_allowed_headers" {
  description = "Allowed headers for blob CORS"
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_allowed_methods" {
  description = "Allowed HTTP methods for blob CORS"
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "blob_cors_allowed_origins" {
  description = "Allowed origins for blob CORS"
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_exposed_headers" {
  description = "Exposed headers for blob CORS"
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_max_age_in_seconds" {
  description = "Max age for blob CORS preflight requests"
  type        = number
  default     = 86400
}

# Queue Properties Configuration
variable "queue_cors_allowed_headers" {
  description = "Allowed headers for queue CORS"
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_allowed_methods" {
  description = "Allowed HTTP methods for queue CORS"
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "queue_cors_allowed_origins" {
  description = "Allowed origins for queue CORS"
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_exposed_headers" {
  description = "Exposed headers for queue CORS"
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_max_age_in_seconds" {
  description = "Max age for queue CORS preflight requests"
  type        = number
  default     = 86400
}

# Queue Logging Configuration
variable "queue_logging_delete" {
  description = "Log delete operations on queues"
  type        = bool
  default     = false
}

variable "queue_logging_read" {
  description = "Log read operations on queues"
  type        = bool
  default     = false
}

variable "queue_logging_write" {
  description = "Log write operations on queues"
  type        = bool
  default     = false
}

variable "queue_logging_version" {
  description = "Logging version for queue operations"
  type        = string
  default     = "1.0"
}

variable "queue_logging_retention_policy_days" {
  description = "Days to retain queue operation logs"
  type        = number
  default     = null
}

# Queue Metrics Configuration
variable "queue_minute_metrics_enabled" {
  description = "Enable minute-level metrics for queues"
  type        = bool
  default     = false
}

variable "queue_minute_metrics_version" {
  description = "Version for minute-level queue metrics"
  type        = string
  default     = "1.0"
}

variable "queue_minute_metrics_include_apis" {
  description = "Include API calls in minute-level metrics"
  type        = bool
  default     = false
}

variable "queue_minute_metrics_retention_policy_days" {
  description = "Days to retain minute-level queue metrics"
  type        = number
  default     = null
}

variable "queue_hour_metrics_enabled" {
  description = "Enable hour-level metrics for queues"
  type        = bool
  default     = false
}

variable "queue_hour_metrics_version" {
  description = "Version for hour-level queue metrics"
  type        = string
  default     = "1.0"
}

variable "queue_hour_metrics_include_apis" {
  description = "Include API calls in hour-level metrics"
  type        = bool
  default     = false
}

variable "queue_hour_metrics_retention_policy_days" {
  description = "Days to retain hour-level queue metrics"
  type        = number
  default     = null
}

# Static Website Configuration
variable "static_website_index_document" {
  description = "Index document for static website hosting"
  type        = string
  default     = null
}

variable "static_website_error_404_document" {
  description = "404 error document for static website hosting"
  type        = string
  default     = null
}

# File Share Properties Configuration
variable "share_cors_allowed_headers" {
  description = "Allowed headers for file share CORS"
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_allowed_methods" {
  description = "Allowed HTTP methods for file share CORS"
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "share_cors_allowed_origins" {
  description = "Allowed origins for file share CORS"
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_exposed_headers" {
  description = "Exposed headers for file share CORS"
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_max_age_in_seconds" {
  description = "Max age for file share CORS preflight requests"
  type        = number
  default     = 86400
}

variable "share_retention_policy_days" {
  description = "Days to retain deleted file shares"
  type        = number
  default     = null
}

# SMB Configuration for File Shares
variable "share_smb_versions" {
  description = "SMB versions to enable for file shares"
  type        = list(string)
  default     = ["SMB3"]
  validation {
    condition     = alltrue([for version in var.share_smb_versions : contains(["SMB2.1", "SMB3"], version)])
    error_message = "SMB versions must be either 'SMB2.1' or 'SMB3'."
  }
}

variable "share_smb_authentication_types" {
  description = "SMB authentication types to enable"
  type        = list(string)
  default     = ["NTLMv2"]
  validation {
    condition     = alltrue([for auth in var.share_smb_authentication_types : contains(["NTLMv2", "Kerberos"], auth)])
    error_message = "SMB authentication types must be either 'NTLMv2' or 'Kerberos'."
  }
}

variable "share_smb_kerberos_ticket_encryption_type" {
  description = "Kerberos ticket encryption type for SMB"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "RC4"], var.share_smb_kerberos_ticket_encryption_type)
    error_message = "Kerberos ticket encryption type must be either 'AES256' or 'RC4'."
  }
}

variable "share_smb_channel_encryption_type" {
  description = "SMB channel encryption type"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "AES128"], var.share_smb_channel_encryption_type)
    error_message = "SMB channel encryption type must be either 'AES256' or 'AES128'."
  }
}

variable "share_smb_multichannel_enabled" {
  description = "Enable SMB multichannel for performance"
  type        = bool
  default     = false
}

# Network Rules Configuration
variable "network_rules_default_action" {
  description = "Default action for network rules - Allow or Deny"
  type        = string
  default     = "Allow"
  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "Network rules default action must be either 'Allow' or 'Deny'."
  }
}

variable "network_rules_bypass" {
  description = "Services to bypass network rules - AzureServices, Logging, Metrics, None"
  type        = list(string)
  default     = ["AzureServices"]
  validation {
    condition     = alltrue([for bypass in var.network_rules_bypass : contains(["AzureServices", "Logging", "Metrics", "None"], bypass)])
    error_message = "Network rules bypass must be one of: AzureServices, Logging, Metrics, None."
  }
}

variable "network_rules_ip_rules" {
  description = "IP addresses or ranges allowed to access storage"
  type        = list(string)
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "VNet subnet IDs allowed to access storage"
  type        = list(string)
  default     = []
}

variable "network_rules_private_link_access_endpoint_tenant_id" {
  description = "Tenant ID for private link access endpoint"
  type        = string
  default     = null
}

variable "network_rules_private_link_access_endpoint_resource_id" {
  description = "Resource ID for private link access endpoint"
  type        = string
  default     = null
}

# Routing Configuration
variable "routing_publish_internet_endpoints" {
  description = "Publish internet endpoints for routing"
  type        = bool
  default     = false
}

variable "routing_publish_microsoft_endpoints" {
  description = "Publish Microsoft endpoints for routing"
  type        = bool
  default     = false
}

variable "routing_choice" {
  description = "Routing choice - MicrosoftRouting, InternetRouting, or Both"
  type        = string
  default     = "MicrosoftRouting"
  validation {
    condition     = contains(["MicrosoftRouting", "InternetRouting", "Both"], var.routing_choice)
    error_message = "Routing choice must be one of: MicrosoftRouting, InternetRouting, Both."
  }
}

# Encryption Configuration
variable "queue_encryption_key_type" {
  description = "Encryption key type for queues - Service or Account"
  type        = string
  default     = "Service"
  validation {
    condition     = contains(["Service", "Account"], var.queue_encryption_key_type)
    error_message = "Queue encryption key type must be either 'Service' or 'Account'."
  }
}

variable "table_encryption_key_type" {
  description = "Encryption key type for tables - Service or Account"
  type        = string
  default     = "Service"
  validation {
    condition     = contains(["Service", "Account"], var.table_encryption_key_type)
    error_message = "Table encryption key type must be either 'Service' or 'Account'."
  }
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Resource Creation Flags
variable "create_separate_network_rules" {
  description = "Create network rules as separate resource to avoid update issues"
  type        = bool
  default     = false
}

variable "create_management_policy" {
  description = "Create lifecycle management policy"
  type        = bool
  default     = false
}

variable "create_customer_managed_key" {
  description = "Create customer-managed key configuration"
  type        = bool
  default     = false
}

variable "create_blob_inventory_policy" {
  description = "Create blob inventory policy for compliance reporting"
  type        = bool
  default     = false
}

# Storage Services Configuration
variable "containers" {
  description = "Blob containers to create with access type and metadata"
  type = map(object({
    container_access_type = string
    metadata             = map(string)
  }))
  default = {}
}

variable "queues" {
  description = "Queue storage to create with metadata"
  type = map(object({
    metadata = map(string)
  }))
  default = {}
}

variable "tables" {
  description = "Table storage to create with ACL configuration"
  type = map(object({
    acl_id        = string
    acl_permissions = string
    acl_start     = string
    acl_expiry    = string
  }))
  default = {}
}

variable "file_shares" {
  description = "File shares to create with quota and ACL configuration"
  type = map(object({
    quota         = number
    metadata      = map(string)
    acl_id        = string
    acl_permissions = string
    acl_start     = string
    acl_expiry    = string
  }))
  default = {}
}

# Management Policy Configuration
variable "management_policy_rules" {
  description = "Lifecycle management policy rules for automated data tiering"
  type = list(object({
    name    = string
    enabled = bool
    filters = object({
      blob_types   = list(string)
      prefix_match = list(string)
    })
    actions = object({
      base_blob = object({
        tier_to_cool_after_days_since_modification_greater_than    = number
        tier_to_archive_after_days_since_modification_greater_than = number
        delete_after_days_since_modification_greater_than          = number
      })
      snapshot = object({
        tier_to_cool_after_days_since_creation_greater_than    = number
        tier_to_archive_after_days_since_creation_greater_than = number
        delete_after_days_since_creation_greater_than          = number
      })
      version = object({
        tier_to_cool_after_days_since_creation_greater_than    = number
        tier_to_archive_after_days_since_creation_greater_than = number
        delete_after_days_since_creation_greater_than          = number
      })
    })
  }))
  default = []
}

# Customer Managed Key Configuration
variable "customer_managed_key_vault_id" {
  description = "Key Vault ID for customer-managed encryption keys"
  type        = string
  default     = null
}

variable "customer_managed_key_name" {
  description = "Key name in Key Vault for encryption"
  type        = string
  default     = null
}

variable "customer_managed_key_version" {
  description = "Key version in Key Vault for encryption"
  type        = string
  default     = null
}

# Local Users Configuration
variable "local_users" {
  description = "Local users for SFTP access with SSH keys and permissions"
  type = map(object({
    home_directory       = string
    ssh_key_description  = string
    ssh_key             = string
    ssh_password_enabled = bool
    permissions = object({
      read   = bool
      write  = bool
      delete = bool
      list   = bool
    })
    resource_name = string
    service       = string
    sid           = string
  }))
  default = {}
}

# Encryption Scopes Configuration
variable "encryption_scopes" {
  description = "Encryption scopes for granular encryption control"
  type = map(object({
    source           = string
    key_vault_key_id = string
  }))
  default = {}
}

# Data Lake Filesystems Configuration
variable "data_lake_filesystems" {
  description = "Data Lake Gen2 filesystems with properties"
  type = map(object({
    properties = map(string)
  }))
  default = {}
}

# Blob Inventory Policy Configuration
variable "blob_inventory_policy_rules" {
  description = "Blob inventory policy rules for compliance reporting"
  type = list(object({
    name                    = string
    enabled                 = bool
    schedule                = string
    storage_container_name  = string
    format                  = string
    scope                   = string
    schema_fields           = list(string)
  }))
  default = []
} 