# Azure Storage Account Module Variables
# This file contains all variable definitions for the Azure Storage Account module

# Required Variables
variable "storage_account_name" {
  description = "The name of the storage account. Must be globally unique and between 3-24 characters in length."
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters in length."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created."
  type        = string
}

# Storage Account Configuration
variable "account_tier" {
  description = "Defines the tier to use for this storage account. Valid options are Standard and Premium."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  type        = string
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Account replication type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "account_kind" {
  description = "Defines the kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  type        = string
  default     = "StorageV2"
  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Account kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool."
  type        = string
  default     = "Hot"
  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Access tier must be either 'Hot' or 'Cool'."
  }
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist."
  type        = string
  default     = null
}

# Security and Network Configuration
variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Valid options are TLS1_0, TLS1_1, and TLS1_2."
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Minimum TLS version must be one of: TLS1_0, TLS1_1, TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Storage Account to opt into being public."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is allowed for the storage account."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  type        = bool
  default     = false
}

# Advanced Features
variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled?"
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Enable Large File Share for this storage account."
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "Enable local users for this storage account."
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Enable cross tenant replication for this storage account."
  type        = bool
  default     = false
}

variable "sftp_enabled" {
  description = "Enable SFTP for this storage account."
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled?"
  type        = bool
  default     = false
}

variable "immutability_period_since_creation_in_days" {
  description = "The immutability period for the blobs in days."
  type        = number
  default     = null
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet."
  type        = string
  default     = null
  validation {
    condition     = var.allowed_copy_scope == null || contains(["AAD", "PrivateLink"], var.allowed_copy_scope)
    error_message = "Allowed copy scope must be either 'AAD' or 'PrivateLink'."
  }
}

# SAS Policy
variable "sas_policy_expiration_action" {
  description = "The SAS expiration action. Valid options are Log and Block."
  type        = string
  default     = "Log"
  validation {
    condition     = contains(["Log", "Block"], var.sas_policy_expiration_action)
    error_message = "SAS policy expiration action must be either 'Log' or 'Block'."
  }
}

variable "sas_policy_expiration_period" {
  description = "The SAS expiration period in the format of an ISO 8601 duration."
  type        = string
  default     = "P1D"
}

# Custom Domain
variable "custom_domain_name" {
  description = "The Custom Domain Name to use for the Storage Account."
  type        = string
  default     = null
}

variable "custom_domain_use_subdomain" {
  description = "Should the Custom Domain Name be validated by using indirect CNAME validation?"
  type        = bool
  default     = false
}

# Customer Managed Key
variable "customer_managed_key_vault_key_id" {
  description = "The ID of the Key Vault Key which should be used to encrypt data in the Storage Account."
  type        = string
  default     = null
}

variable "customer_managed_user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity that has access to the key."
  type        = string
  default     = null
}

# Identity
variable "identity_type" {
  description = "The type of identity used for the Storage Account. Valid options are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "Identity type must be one of: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."
  }
}

variable "identity_ids" {
  description = "A list of User Assigned Identity IDs to be assigned to this Storage Account."
  type        = list(string)
  default     = []
}

# Blob Properties
variable "blob_versioning_enabled" {
  description = "Is versioning enabled?"
  type        = bool
  default     = false
}

variable "blob_change_feed_enabled" {
  description = "Is the blob service properties for change feed events enabled?"
  type        = bool
  default     = false
}

variable "blob_change_feed_retention_in_days" {
  description = "The duration of change feed events retention in days."
  type        = number
  default     = null
}

variable "blob_default_service_version" {
  description = "The API version which should be used by default for requests to the Data Plane API."
  type        = string
  default     = null
}

variable "blob_last_access_time_enabled" {
  description = "Is the last access time based tracking enabled?"
  type        = bool
  default     = false
}

variable "blob_container_delete_retention_days" {
  description = "The number of days that deleted container should be retained."
  type        = number
  default     = null
}

variable "blob_delete_retention_days" {
  description = "The number of days that deleted blob should be retained."
  type        = number
  default     = null
}

variable "blob_restore_days" {
  description = "The number of days that deleted blob should be retained."
  type        = number
  default     = null
}

# Blob CORS
variable "blob_cors_allowed_headers" {
  description = "A list of headers that are allowed to be a part of the cross-origin request."
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_allowed_methods" {
  description = "A list of HTTP methods that are allowed to be executed by the origin."
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "blob_cors_allowed_origins" {
  description = "A list of origin domains that will be allowed via CORS."
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_exposed_headers" {
  description = "A list of response headers that are exposed to CORS clients."
  type        = list(string)
  default     = ["*"]
}

variable "blob_cors_max_age_in_seconds" {
  description = "The number of seconds that the client should cache a preflight response."
  type        = number
  default     = 86400
}

# Queue Properties
variable "queue_cors_allowed_headers" {
  description = "A list of headers that are allowed to be a part of the cross-origin request."
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_allowed_methods" {
  description = "A list of HTTP methods that are allowed to be executed by the origin."
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "queue_cors_allowed_origins" {
  description = "A list of origin domains that will be allowed via CORS."
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_exposed_headers" {
  description = "A list of response headers that are exposed to CORS clients."
  type        = list(string)
  default     = ["*"]
}

variable "queue_cors_max_age_in_seconds" {
  description = "The number of seconds that the client should cache a preflight response."
  type        = number
  default     = 86400
}

# Queue Logging
variable "queue_logging_delete" {
  description = "Indicates whether all delete requests should be logged."
  type        = bool
  default     = false
}

variable "queue_logging_read" {
  description = "Indicates whether all read requests should be logged."
  type        = bool
  default     = false
}

variable "queue_logging_write" {
  description = "Indicates whether all write requests should be logged."
  type        = bool
  default     = false
}

variable "queue_logging_version" {
  description = "The version of storage analytics to configure."
  type        = string
  default     = "1.0"
}

variable "queue_logging_retention_policy_days" {
  description = "The number of days that logs will be retained."
  type        = number
  default     = 7
}

# Queue Metrics
variable "queue_minute_metrics_enabled" {
  description = "Indicates whether minute metrics are enabled for the Queue service."
  type        = bool
  default     = false
}

variable "queue_minute_metrics_version" {
  description = "The version of storage analytics to configure."
  type        = string
  default     = "1.0"
}

variable "queue_minute_metrics_include_apis" {
  description = "Indicates whether metrics should generate summary statistics for called API operations."
  type        = bool
  default     = false
}

variable "queue_minute_metrics_retention_policy_days" {
  description = "The number of days that metrics will be retained."
  type        = number
  default     = 7
}

variable "queue_hour_metrics_enabled" {
  description = "Indicates whether hour metrics are enabled for the Queue service."
  type        = bool
  default     = false
}

variable "queue_hour_metrics_version" {
  description = "The version of storage analytics to configure."
  type        = string
  default     = "1.0"
}

variable "queue_hour_metrics_include_apis" {
  description = "Indicates whether metrics should generate summary statistics for called API operations."
  type        = bool
  default     = false
}

variable "queue_hour_metrics_retention_policy_days" {
  description = "The number of days that metrics will be retained."
  type        = number
  default     = 7
}

# Static Website
variable "static_website_index_document" {
  description = "The webpage that Azure Storage serves for requests to the root of a website."
  type        = string
  default     = null
}

variable "static_website_error_404_document" {
  description = "The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file."
  type        = string
  default     = null
}

# Share Properties
variable "share_cors_allowed_headers" {
  description = "A list of headers that are allowed to be a part of the cross-origin request."
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_allowed_methods" {
  description = "A list of HTTP methods that are allowed to be executed by the origin."
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "DELETE"]
}

variable "share_cors_allowed_origins" {
  description = "A list of origin domains that will be allowed via CORS."
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_exposed_headers" {
  description = "A list of response headers that are exposed to CORS clients."
  type        = list(string)
  default     = ["*"]
}

variable "share_cors_max_age_in_seconds" {
  description = "The number of seconds that the client should cache a preflight response."
  type        = number
  default     = 86400
}

variable "share_retention_policy_days" {
  description = "The number of days that deleted file shares should be retained."
  type        = number
  default     = null
}

# Share SMB
variable "share_smb_versions" {
  description = "A list of SMB protocol versions."
  type        = list(string)
  default     = ["SMB3"]
  validation {
    condition     = alltrue([for version in var.share_smb_versions : contains(["SMB2.1", "SMB3", "SMB3.0.2"], version)])
    error_message = "SMB versions must be one of: SMB2.1, SMB3, SMB3.0.2."
  }
}

variable "share_smb_authentication_types" {
  description = "A list of SMB authentication methods."
  type        = list(string)
  default     = ["NTLMv2"]
  validation {
    condition     = alltrue([for auth in var.share_smb_authentication_types : contains(["NTLMv2", "Kerberos"], auth)])
    error_message = "SMB authentication types must be one of: NTLMv2, Kerberos."
  }
}

variable "share_smb_kerberos_ticket_encryption_type" {
  description = "A list of Kerberos ticket encryption."
  type        = list(string)
  default     = ["AES256"]
  validation {
    condition     = alltrue([for enc in var.share_smb_kerberos_ticket_encryption_type : contains(["AES128", "AES256"], enc)])
    error_message = "SMB Kerberos ticket encryption type must be one of: AES128, AES256."
  }
}

variable "share_smb_channel_encryption_type" {
  description = "A list of SMB channel encryption."
  type        = list(string)
  default     = ["AES128-CCM", "AES128-GCM", "AES256-GCM"]
  validation {
    condition     = alltrue([for enc in var.share_smb_channel_encryption_type : contains(["AES128-CCM", "AES128-GCM", "AES256-GCM"], enc)])
    error_message = "SMB channel encryption type must be one of: AES128-CCM, AES128-GCM, AES256-GCM."
  }
}

variable "share_smb_multichannel_enabled" {
  description = "Indicates whether multichannel is enabled."
  type        = bool
  default     = false
}

# Network Rules
variable "network_rules_default_action" {
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny and Allow."
  type        = string
  default     = "Allow"
  validation {
    condition     = contains(["Deny", "Allow"], var.network_rules_default_action)
    error_message = "Network rules default action must be either 'Deny' or 'Allow'."
  }
}

variable "network_rules_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are AzureServices, Logging, Metrics, None."
  type        = list(string)
  default     = ["AzureServices"]
  validation {
    condition     = alltrue([for bypass in var.network_rules_bypass : contains(["AzureServices", "Logging", "Metrics", "None"], bypass)])
    error_message = "Network rules bypass must be one of: AzureServices, Logging, Metrics, None."
  }
}

variable "network_rules_ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format."
  type        = list(string)
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "A list of virtual network subnet ids to to secure the storage account."
  type        = list(string)
  default     = []
}

variable "network_rules_private_link_access_endpoint_tenant_id" {
  description = "The tenant id of the resource."
  type        = string
  default     = null
}

variable "network_rules_private_link_access_endpoint_resource_id" {
  description = "The resource id of the resource access rule to configure."
  type        = string
  default     = null
}

# Routing
variable "routing_publish_internet_endpoints" {
  description = "Should internet routing storage endpoints be published?"
  type        = bool
  default     = false
}

variable "routing_publish_microsoft_endpoints" {
  description = "Should Microsoft routing storage endpoints be published?"
  type        = bool
  default     = false
}

variable "routing_choice" {
  description = "Specifies the kind of network routing opted by the user. Valid options are MicrosoftRouting and InternetRouting."
  type        = string
  default     = "MicrosoftRouting"
  validation {
    condition     = contains(["MicrosoftRouting", "InternetRouting"], var.routing_choice)
    error_message = "Routing choice must be either 'MicrosoftRouting' or 'InternetRouting'."
  }
}

# Encryption
variable "queue_encryption_key_type" {
  description = "Encryption key type for the queue. Valid options are Account and Service."
  type        = string
  default     = "Account"
  validation {
    condition     = contains(["Account", "Service"], var.queue_encryption_key_type)
    error_message = "Queue encryption key type must be either 'Account' or 'Service'."
  }
}

variable "table_encryption_key_type" {
  description = "Encryption key type for the table. Valid options are Account and Service."
  type        = string
  default     = "Account"
  validation {
    condition     = contains(["Account", "Service"], var.table_encryption_key_type)
    error_message = "Table encryption key type must be either 'Account' or 'Service'."
  }
}

# Tags
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# Optional Resources
variable "create_separate_network_rules" {
  description = "Whether to create network rules as a separate resource."
  type        = bool
  default     = false
}

variable "create_management_policy" {
  description = "Whether to create a management policy for the storage account."
  type        = bool
  default     = false
}

variable "create_customer_managed_key" {
  description = "Whether to create a customer managed key for the storage account."
  type        = bool
  default     = false
}

variable "create_blob_inventory_policy" {
  description = "Whether to create a blob inventory policy for the storage account."
  type        = bool
  default     = false
}

# Complex Variables
variable "containers" {
  description = "Map of storage containers to create."
  type = map(object({
    container_access_type = string
    metadata             = map(string)
  }))
  default = {}
}

variable "queues" {
  description = "Map of storage queues to create."
  type = map(object({
    metadata = map(string)
  }))
  default = {}
}

variable "tables" {
  description = "Map of storage tables to create."
  type = map(object({
    acl_id        = string
    acl_permissions = string
    acl_start     = string
    acl_expiry    = string
  }))
  default = {}
}

variable "file_shares" {
  description = "Map of storage file shares to create."
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

variable "management_policy_rules" {
  description = "List of management policy rules."
  type = list(object({
    name    = string
    enabled = bool
    filters = object({
      blob_types   = list(string)
      prefix_match = list(string)
      match_blob_index_tag = object({
        name      = string
        operation = string
        value     = string
      })
    })
    actions = object({
      base_blob = object({
        tier_to_cool_after_days_since_modification_greater_than    = number
        tier_to_archive_after_days_since_modification_greater_than = number
        delete_after_days_since_modification_greater_than          = number
        auto_tier_to_hot_from_cool_enabled                         = bool
      })
      snapshot = object({
        delete_after_days_since_creation_greater_than = number
        tier_to_cool_after_days_since_creation_greater_than    = number
        tier_to_archive_after_days_since_creation_greater_than = number
      })
      version = object({
        delete_after_days_since_creation = number
        tier_to_cool_after_days_since_creation    = number
        tier_to_archive_after_days_since_creation = number
      })
    })
  }))
  default = []
}

variable "customer_managed_key_vault_id" {
  description = "The ID of the Key Vault which should be used to encrypt data in the Storage Account."
  type        = string
  default     = null
}

variable "customer_managed_key_name" {
  description = "The name of the Key Vault Key which should be used to encrypt data in the Storage Account."
  type        = string
  default     = null
}

variable "customer_managed_key_version" {
  description = "The version of the Key Vault Key which should be used to encrypt data in the Storage Account."
  type        = string
  default     = null
}

variable "local_users" {
  description = "Map of local users to create."
  type = map(object({
    home_directory = string
    ssh_authorized_key = object({
      description = string
      key         = string
    })
    permission_scope = object({
      permissions = object({
        read   = bool
        write  = bool
        delete = bool
        list   = bool
      })
      service       = string
      resource_name = string
    })
    ssh_password_enabled = bool
  }))
  default = {}
}

variable "encryption_scopes" {
  description = "Map of encryption scopes to create."
  type = map(object({
    source           = string
    key_vault_key_id = string
  }))
  default = {}
}

variable "data_lake_filesystems" {
  description = "Map of data lake filesystems to create."
  type = map(object({
    properties = map(string)
    ace = object({
      permissions = string
      type        = string
      id          = string
      scope       = string
    })
  }))
  default = {}
}

variable "blob_inventory_policy_rules" {
  description = "List of blob inventory policy rules."
  type = list(object({
    name = string
    filter = object({
      blob_types        = list(string)
      include_blob_versions = bool
      include_snapshots     = bool
      include_deleted       = bool
      prefix_match          = list(string)
      exclude_prefixes      = list(string)
    })
    format                 = string
    schedule               = string
    storage_container_name = string
  }))
  default = []
} 