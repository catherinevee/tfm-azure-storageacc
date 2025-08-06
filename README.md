# Azure Storage Account Terraform Module

Terraform module for Azure Storage Account deployment with support for all storage services and security features.

## What This Module Creates

### Core Resources
| Resource | Purpose | Required |
|----------|---------|----------|
| `azurerm_storage_account` | Main storage account | Yes |
| `azurerm_storage_account_network_rules` | Network access control | No |
| `azurerm_storage_account_customer_managed_key` | Custom encryption keys | No |

### Storage Services
| Resource | Purpose | Required |
|----------|---------|----------|
| `azurerm_storage_container` | Blob containers | No |
| `azurerm_storage_queue` | Queue storage | No |
| `azurerm_storage_table` | Table storage | No |
| `azurerm_storage_share` | File shares | No |
| `azurerm_storage_account_local_user` | Local user accounts | No |
| `azurerm_storage_encryption_scope` | Granular encryption | No |
| `azurerm_storage_data_lake_gen2_filesystem` | Data Lake Gen2 | No |

### Management & Compliance
| Resource | Purpose | Required |
|----------|---------|----------|
| `azurerm_storage_management_policy` | Lifecycle management | No |
| `azurerm_storage_blob_inventory_policy` | Compliance reporting | No |

### Dependencies
- Storage account must exist before other resources
- Network rules apply after account creation
- Customer managed keys require Key Vault access
- Data Lake features need HNS enabled

## Key Features

### Storage Options
- **Account Types**: StorageV2, BlobStorage, BlockBlobStorage, FileStorage
- **Performance Tiers**: Standard and Premium
- **Replication**: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS
- **Access Tiers**: Hot and Cool for cost optimization

### Security & Compliance
- **Encryption**: Infrastructure and customer-managed keys
- **Network Security**: Private endpoints, IP restrictions, VNet integration
- **Authentication**: OAuth, Shared Key, SAS policies
- **TLS**: Configurable minimum versions
- **Public Access**: Control over public exposure

### Advanced Capabilities
- **Data Lake Gen2**: Hierarchical namespace support
- **SFTP**: Secure file transfer
- **NFSv3**: Network file system support
- **Large File Shares**: For big data workloads
- **Cross-Tenant Replication**: Multi-tenant scenarios

### Storage Services
- **Blob Storage**: Containers with versioning and change feed
- **Queue Storage**: Message queuing with logging
- **Table Storage**: NoSQL data storage
- **File Storage**: SMB file shares
- **Static Website**: Web hosting capabilities

### Data Management
- **Lifecycle Policies**: Automatic tiering and cleanup
- **Blob Inventory**: Compliance and audit reporting
- **Encryption Scopes**: Service-level encryption control

## Usage

### Basic Setup

```hcl
module "storage_account" {
  source = "./tfm-azure-storageacc"

  storage_account_name = "mystorageaccount"
  resource_group_name  = "my-resource-group"
  location            = "East US"
}
```

### Production Configuration

```hcl
module "storage_account" {
  source = "./tfm-azure-storageacc"

  # Required
  storage_account_name = "mystorageaccount"
  resource_group_name  = "my-resource-group"
  location            = "East US"

  # Performance and availability
  account_tier             = "Premium"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security hardening
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  public_network_access_enabled = false
  default_to_oauth_authentication = true

  # Advanced features
  is_hns_enabled            = true
  large_file_share_enabled  = true
  local_user_enabled        = true
  sftp_enabled              = true

  # Network restrictions
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

  # Lifecycle management
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
| terraform | ~> 1.13.0 |
| azurerm | ~> 4.38.1 |

## Inputs

### Required Parameters

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| storage_account_name | Storage account name (3-24 chars, globally unique) | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |

### Storage Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_tier | Performance tier (Standard/Premium) | `string` | `"Standard"` | no |
| account_replication_type | Replication strategy | `string` | `"LRS"` | no |
| account_kind | Account type | `string` | `"StorageV2"` | no |
| access_tier | Data access tier (Hot/Cool) | `string` | `"Hot"` | no |
| edge_zone | Edge zone deployment | `string` | `null` | no |

### Security Settings

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable_https_traffic_only | Force HTTPS traffic | `bool` | `true` | no |
| min_tls_version | Minimum TLS version | `string` | `"TLS1_2"` | no |
| allow_nested_items_to_be_public | Allow public nested items | `bool` | `false` | no |
| shared_access_key_enabled | Enable shared key auth | `bool` | `true` | no |
| public_network_access_enabled | Allow public network access | `bool` | `true` | no |
| default_to_oauth_authentication | Default to Azure AD auth | `bool` | `false` | no |

### Advanced Features

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| is_hns_enabled | Enable hierarchical namespace | `bool` | `false` | no |
| nfsv3_enabled | Enable NFSv3 protocol | `bool` | `false` | no |
| large_file_share_enabled | Enable large file shares | `bool` | `false` | no |
| local_user_enabled | Enable local users | `bool` | `false` | no |
| cross_tenant_replication_enabled | Enable cross-tenant replication | `bool` | `false` | no |
| sftp_enabled | Enable SFTP | `bool` | `false` | no |
| infrastructure_encryption_enabled | Enable infrastructure encryption | `bool` | `false` | no |

### Network Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network_rules_default_action | Default network action | `string` | `"Allow"` | no |
| network_rules_bypass | Traffic bypass options | `list(string)` | `["AzureServices"]` | no |
| network_rules_ip_rules | Allowed IP ranges | `list(string)` | `[]` | no |
| network_rules_virtual_network_subnet_ids | Allowed VNet subnets | `list(string)` | `[]` | no |

### Storage Services

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| containers | Blob containers to create | `map(object)` | `{}` | no |
| queues | Queue storage to create | `map(object)` | `{}` | no |
| tables | Table storage to create | `map(object)` | `{}` | no |
| file_shares | File shares to create | `map(object)` | `{}` | no |
| local_users | Local users to create | `map(object)` | `{}` | no |
| encryption_scopes | Encryption scopes to create | `map(object)` | `{}` | no |
| data_lake_filesystems | Data Lake filesystems to create | `map(object)` | `{}` | no |

### Management & Policies

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_management_policy | Create lifecycle policy | `bool` | `false` | no |
| management_policy_rules | Lifecycle rules | `list(object)` | `[]` | no |
| create_blob_inventory_policy | Create inventory policy | `bool` | `false` | no |
| blob_inventory_policy_rules | Inventory rules | `list(object)` | `[]` | no |

### Customer Managed Keys

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_customer_managed_key | Use customer-managed keys | `bool` | `false` | no |
| customer_managed_key_vault_id | Key Vault ID | `string` | `null` | no |
| customer_managed_key_name | Key name | `string` | `null` | no |
| customer_managed_key_version | Key version | `string` | `null` | no |

### Tags

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

### Storage Account Information

| Name | Description |
|------|-------------|
| storage_account_id | Storage account resource ID |
| storage_account_name | Storage account name |
| storage_account_primary_location | Primary region |
| storage_account_secondary_location | Secondary region |
| storage_account_info | Complete account information |

### Access & Connection

| Name | Description |
|------|-------------|
| storage_account_primary_access_key | Primary access key (sensitive) |
| storage_account_secondary_access_key | Secondary access key (sensitive) |
| storage_account_primary_connection_string | Primary connection string (sensitive) |
| storage_account_secondary_connection_string | Secondary connection string (sensitive) |

### Endpoints

| Name | Description |
|------|-------------|
| storage_account_primary_blob_endpoint | Blob service endpoint |
| storage_account_primary_queue_endpoint | Queue service endpoint |
| storage_account_primary_table_endpoint | Table service endpoint |
| storage_account_primary_file_endpoint | File service endpoint |
| storage_account_primary_web_endpoint | Static website endpoint |
| storage_account_primary_dfs_endpoint | Data Lake endpoint |
| storage_account_endpoints | All endpoints summary |

### Storage Services

| Name | Description |
|------|-------------|
| storage_containers | Created blob containers |
| storage_queues | Created queue storage |
| storage_tables | Created table storage |
| storage_file_shares | Created file shares |
| storage_account_local_users | Created local users |
| storage_account_encryption_scopes | Created encryption scopes |
| storage_account_data_lake_filesystems | Created Data Lake filesystems |

### Security & Configuration

| Name | Description |
|------|-------------|
| storage_account_security_info | Security configuration details |
| storage_account_features_info | Feature configuration details |
| storage_account_identity | Managed identity configuration |
| storage_account_network_rules | Network rules configuration |

## Examples

See the [examples](./examples/) directory:

- [Basic Example](./examples/basic/) - Minimal configuration
- [Advanced Example](./examples/advanced/) - Full feature set

## Best Practices

### Security
1. **Private Endpoints**: Use for secure access patterns
2. **Customer Managed Keys**: For compliance requirements
3. **Network Restrictions**: Limit access to trusted sources
4. **HTTPS Only**: Enforce secure transport
5. **OAuth Default**: Use Azure AD when possible

### Performance
1. **Premium Tier**: For high-performance workloads
2. **ZRS Replication**: Better availability in supported regions
3. **Large File Shares**: For big data scenarios
4. **Appropriate Access Tier**: Hot for frequent access, Cool for archival

### Cost Management
1. **Cool Tier**: For infrequently accessed data
2. **Lifecycle Policies**: Automatic tiering and cleanup
3. **Retention Policies**: Delete obsolete data
4. **Usage Monitoring**: Track consumption patterns

### Compliance
1. **Versioning**: For data protection
2. **Change Feed**: For audit trails
3. **Inventory Policies**: For compliance reporting
4. **Encryption Scopes**: For granular control

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Support

For issues and questions:
- Check the [examples](./examples/) for usage patterns
- Review the [Azure Storage documentation](https://docs.microsoft.com/en-us/azure/storage/)
- Open an issue in the repository

## Changelog

### Version 1.0.0
- Initial release
- Complete Azure Storage Account module
- All major features and services supported
- Security and compliance options
- Examples and documentation