# Azure Storage Account Terraform Module

A comprehensive Terraform module for creating and managing Azure Storage Accounts with all available features and customization options.

## Features

This module provides a complete solution for Azure Storage Account management with the following capabilities:

### Core Storage Account Features
- **Account Types**: Support for all account kinds (StorageV2, BlobStorage, BlockBlobStorage, FileStorage, Storage)
- **Tiers**: Standard and Premium tiers
- **Replication**: All replication types (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)
- **Access Tiers**: Hot and Cool access tiers
- **Edge Zones**: Support for edge zone deployment

### Security & Compliance
- **Encryption**: Infrastructure encryption, customer managed keys
- **Network Security**: Private endpoints, network rules, IP restrictions
- **Authentication**: OAuth, Shared Key, SAS policies
- **TLS**: Configurable minimum TLS versions
- **Public Access**: Control over public access and nested item public access

### Advanced Features
- **Hierarchical Namespace**: Data Lake Gen2 support
- **SFTP**: Secure File Transfer Protocol
- **NFSv3**: Network File System v3 support
- **Large File Shares**: Support for large file shares
- **Local Users**: Local user management
- **Cross-Tenant Replication**: Multi-tenant replication support

### Storage Services
- **Blob Storage**: Containers with versioning, change feed, CORS
- **Queue Storage**: Queues with logging and metrics
- **Table Storage**: Tables with access control
- **File Storage**: File shares with SMB configuration
- **Static Website**: Static website hosting

### Data Management
- **Lifecycle Management**: Automated tiering and deletion policies
- **Blob Inventory**: Inventory policies for compliance
- **Encryption Scopes**: Granular encryption control
- **Data Lake Gen2**: Filesystem management

### Monitoring & Analytics
- **Logging**: Comprehensive logging configuration
- **Metrics**: Minute and hour-level metrics
- **CORS**: Cross-Origin Resource Sharing
- **Retention Policies**: Configurable retention periods

## Usage

### Basic Usage

```hcl
module "storage_account" {
  source = "./tfm-azure-storageacc"

  storage_account_name = "mystorageaccount"
  resource_group_name  = "my-resource-group"
  location            = "East US"
}
```

### Advanced Usage

```hcl
module "storage_account" {
  source = "./tfm-azure-storageacc"

  # Required parameters
  storage_account_name = "mystorageaccount"
  resource_group_name  = "my-resource-group"
  location            = "East US"

  # Advanced configuration
  account_tier             = "Premium"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security settings
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  public_network_access_enabled = false
  default_to_oauth_authentication = true

  # Advanced features
  is_hns_enabled            = true
  large_file_share_enabled  = true
  local_user_enabled        = true
  sftp_enabled              = true

  # Network rules
  network_rules_default_action = "Deny"
  network_rules_bypass         = ["AzureServices"]
  network_rules_ip_rules       = ["203.0.113.0/24"]
  network_rules_virtual_network_subnet_ids = ["/subscriptions/.../subnets/private-endpoints"]

  # Storage containers
  containers = {
    "data" = {
      container_access_type = "private"
      metadata = {
        environment = "production"
        purpose     = "data-storage"
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
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days_since_modification_greater_than    = 30
          tier_to_archive_after_days_since_modification_greater_than = 90
          delete_after_days_since_modification_greater_than          = 365
        }
      }
    }
  ]

  tags = {
    Environment = "Production"
    Project     = "My Project"
    Owner       = "DevOps Team"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0.0 |

## Inputs

### Required Parameters

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| storage_account_name | The name of the storage account. Must be globally unique and between 3-24 characters in length. | `string` | n/a | yes |
| resource_group_name | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| location | The Azure region where the storage account will be created. | `string` | n/a | yes |

### Storage Account Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_tier | Defines the tier to use for this storage account. Valid options are Standard and Premium. | `string` | `"Standard"` | no |
| account_replication_type | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. | `string` | `"LRS"` | no |
| account_kind | Defines the kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. | `string` | `"StorageV2"` | no |
| access_tier | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool. | `string` | `"Hot"` | no |
| edge_zone | Specifies the Edge Zone within the Azure Region where this Storage Account should exist. | `string` | `null` | no |

### Security Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable_https_traffic_only | Boolean flag which forces HTTPS if enabled. | `bool` | `true` | no |
| min_tls_version | The minimum supported TLS version for the storage account. Valid options are TLS1_0, TLS1_1, and TLS1_2. | `string` | `"TLS1_2"` | no |
| allow_nested_items_to_be_public | Allow or disallow nested items within this Storage Account to opt into being public. | `bool` | `false` | no |
| shared_access_key_enabled | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. | `bool` | `true` | no |
| public_network_access_enabled | Whether the public network access is allowed for the storage account. | `bool` | `true` | no |
| default_to_oauth_authentication | Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. | `bool` | `false` | no |

### Advanced Features

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| is_hns_enabled | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. | `bool` | `false` | no |
| nfsv3_enabled | Is NFSv3 protocol enabled? | `bool` | `false` | no |
| large_file_share_enabled | Enable Large File Share for this storage account. | `bool` | `false` | no |
| local_user_enabled | Enable local users for this storage account. | `bool` | `false` | no |
| cross_tenant_replication_enabled | Enable cross tenant replication for this storage account. | `bool` | `false` | no |
| sftp_enabled | Enable SFTP for this storage account. | `bool` | `false` | no |
| infrastructure_encryption_enabled | Is infrastructure encryption enabled? | `bool` | `false` | no |

### Network Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network_rules_default_action | Specifies the default action of allow or deny when no other rules match. Valid options are Deny and Allow. | `string` | `"Allow"` | no |
| network_rules_bypass | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are AzureServices, Logging, Metrics, None. | `list(string)` | `["AzureServices"]` | no |
| network_rules_ip_rules | List of public IP or IP ranges in CIDR Format. | `list(string)` | `[]` | no |
| network_rules_virtual_network_subnet_ids | A list of virtual network subnet ids to to secure the storage account. | `list(string)` | `[]` | no |

### Storage Services Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| containers | Map of storage containers to create. | `map(object)` | `{}` | no |
| queues | Map of storage queues to create. | `map(object)` | `{}` | no |
| tables | Map of storage tables to create. | `map(object)` | `{}` | no |
| file_shares | Map of storage file shares to create. | `map(object)` | `{}` | no |
| local_users | Map of local users to create. | `map(object)` | `{}` | no |
| encryption_scopes | Map of encryption scopes to create. | `map(object)` | `{}` | no |
| data_lake_filesystems | Map of data lake filesystems to create. | `map(object)` | `{}` | no |

### Management & Policies

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_management_policy | Whether to create a management policy for the storage account. | `bool` | `false` | no |
| management_policy_rules | List of management policy rules. | `list(object)` | `[]` | no |
| create_blob_inventory_policy | Whether to create a blob inventory policy for the storage account. | `bool` | `false` | no |
| blob_inventory_policy_rules | List of blob inventory policy rules. | `list(object)` | `[]` | no |

### Customer Managed Keys

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_customer_managed_key | Whether to create a customer managed key for the storage account. | `bool` | `false` | no |
| customer_managed_key_vault_id | The ID of the Key Vault which should be used to encrypt data in the Storage Account. | `string` | `null` | no |
| customer_managed_key_name | The name of the Key Vault Key which should be used to encrypt data in the Storage Account. | `string` | `null` | no |
| customer_managed_key_version | The version of the Key Vault Key which should be used to encrypt data in the Storage Account. | `string` | `null` | no |

### Tags

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

### Storage Account Information

| Name | Description |
|------|-------------|
| storage_account_id | The ID of the Storage Account. |
| storage_account_name | The name of the Storage Account. |
| storage_account_primary_location | The primary location of the Storage Account. |
| storage_account_secondary_location | The secondary location of the Storage Account. |
| storage_account_info | Comprehensive information about the Storage Account. |

### Access Keys & Connection Strings

| Name | Description |
|------|-------------|
| storage_account_primary_access_key | The primary access key for the Storage Account. |
| storage_account_secondary_access_key | The secondary access key for the Storage Account. |
| storage_account_primary_connection_string | The primary connection string for the Storage Account. |
| storage_account_secondary_connection_string | The secondary connection string for the Storage Account. |

### Endpoints

| Name | Description |
|------|-------------|
| storage_account_primary_blob_endpoint | The primary blob endpoint of the Storage Account. |
| storage_account_primary_queue_endpoint | The primary queue endpoint of the Storage Account. |
| storage_account_primary_table_endpoint | The primary table endpoint of the Storage Account. |
| storage_account_primary_file_endpoint | The primary file endpoint of the Storage Account. |
| storage_account_primary_web_endpoint | The primary web endpoint of the Storage Account. |
| storage_account_primary_dfs_endpoint | The primary DFS endpoint of the Storage Account. |
| storage_account_endpoints | Summary of all Storage Account endpoints. |

### Storage Services

| Name | Description |
|------|-------------|
| storage_containers | Map of storage containers created. |
| storage_queues | Map of storage queues created. |
| storage_tables | Map of storage tables created. |
| storage_file_shares | Map of storage file shares created. |
| storage_account_local_users | Map of storage account local users created. |
| storage_account_encryption_scopes | Map of storage account encryption scopes created. |
| storage_account_data_lake_filesystems | Map of storage account data lake filesystems created. |

### Security & Configuration

| Name | Description |
|------|-------------|
| storage_account_security_info | Security-related information about the Storage Account. |
| storage_account_features_info | Feature-related information about the Storage Account. |
| storage_account_identity | The identity configuration of the Storage Account. |
| storage_account_network_rules | The network rules configuration of the Storage Account. |

## Examples

See the [examples](./examples/) directory for complete working examples:

- [Basic Example](./examples/basic/) - Simple storage account with minimal configuration
- [Advanced Example](./examples/advanced/) - Comprehensive storage account with all features

## Best Practices

### Security
1. **Use Private Endpoints**: Configure private endpoints for secure access
2. **Enable Customer Managed Keys**: Use Azure Key Vault for encryption key management
3. **Restrict Network Access**: Use network rules to limit access to trusted sources
4. **Enable HTTPS Only**: Force HTTPS traffic for all operations
5. **Use OAuth Authentication**: Default to Azure AD authentication when possible

### Performance
1. **Choose Appropriate Tier**: Use Premium tier for high-performance workloads
2. **Select Right Replication**: Choose replication based on availability and cost requirements
3. **Enable Large File Shares**: For workloads requiring large file shares
4. **Use ZRS**: For better availability in supported regions

### Cost Optimization
1. **Use Cool Access Tier**: For infrequently accessed data
2. **Configure Lifecycle Policies**: Automatically move data to cheaper tiers
3. **Set Retention Policies**: Delete data when no longer needed
4. **Monitor Usage**: Use metrics and logging to track usage patterns

### Compliance
1. **Enable Versioning**: For data protection and compliance
2. **Configure Change Feed**: For audit trails
3. **Set Up Inventory Policies**: For compliance reporting
4. **Use Encryption Scopes**: For granular encryption control

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This module is licensed under the MIT License. See the LICENSE file for details.

## Support

For issues and questions:
- Check the [examples](./examples/) for usage patterns
- Review the [Azure Storage documentation](https://docs.microsoft.com/en-us/azure/storage/)
- Open an issue in the repository

## Changelog

### Version 1.0.0
- Initial release
- Comprehensive Azure Storage Account module
- Support for all major features and services
- Advanced security and compliance options
- Complete examples and documentation