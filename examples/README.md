# Azure Storage Account Module Examples

This directory contains examples demonstrating how to use the Azure Storage Account Terraform module.

## Examples Overview

### Basic Examples

#### Basic Example (`basic/`)
A simple example showing the basic usage of the Azure Storage Account module with minimal configuration.

**Features demonstrated:**
- Basic storage account creation
- Standard security settings
- Simple tagging
- Basic outputs

**Usage:**
```bash
cd examples/basic
terraform init
terraform plan
terraform apply
```

#### Basic with Containers (`basic-with-containers/`)
Demonstrates storage account creation with multiple blob containers for different purposes.

**Features demonstrated:**
- Storage account with containers
- Different container access types (private, blob)
- Container metadata
- Container-specific outputs

**Usage:**
```bash
cd examples/basic-with-containers
terraform init
terraform plan
terraform apply
```

#### Basic with Queues (`basic-with-queues/`)
Shows how to create a storage account with message queues for application messaging.

**Features demonstrated:**
- Storage account with queues
- Queue metadata configuration
- Queue-specific outputs
- Message queuing setup

**Usage:**
```bash
cd examples/basic-with-queues
terraform init
terraform plan
terraform apply
```

#### Basic with File Shares (`basic-with-file-shares/`)
Demonstrates storage account creation with file shares for shared storage.

**Features demonstrated:**
- Storage account with file shares
- File share quotas and metadata
- Access control lists (ACLs)
- File share outputs

**Usage:**
```bash
cd examples/basic-with-file-shares
terraform init
terraform plan
terraform apply
```

#### Basic Static Website (`basic-static-website/`)
Shows how to configure a storage account for static website hosting.

**Features demonstrated:**
- Static website configuration
- Index and error document setup
- Web-optimized containers
- Static website endpoints

**Usage:**
```bash
cd examples/basic-static-website
terraform init
terraform plan
terraform apply
```

#### Basic with Lifecycle Policy (`basic-with-lifecycle-policy/`)
Demonstrates storage account with automated lifecycle management policies.

**Features demonstrated:**
- Lifecycle management policies
- Automated tiering (Hot → Cool → Archive)
- Retention policies
- Blob versioning and change feed

**Usage:**
```bash
cd examples/basic-with-lifecycle-policy
terraform init
terraform plan
terraform apply
```

#### Basic with Network Rules (`basic-with-network-rules/`)
Shows how to secure a storage account with network access rules.

**Features demonstrated:**
- Network security rules
- Virtual network integration
- IP address restrictions
- Private network access

**Usage:**
```bash
cd examples/basic-with-network-rules
terraform init
terraform plan
terraform apply
```

#### Basic Premium Storage (`basic-premium-storage/`)
Demonstrates Premium tier storage account for high-performance workloads.

**Features demonstrated:**
- Premium storage tier
- High-performance features
- Infrastructure encryption
- Large file share support

**Usage:**
```bash
cd examples/basic-premium-storage
terraform init
terraform plan
terraform apply
```

### Advanced Example (`advanced/`)
A comprehensive example showing advanced features and configurations of the Azure Storage Account module.

**Features demonstrated:**
- Premium storage account with ZRS replication
- Advanced security features (private endpoints, customer managed keys)
- Hierarchical namespace (Data Lake Gen2)
- Blob versioning and change feed
- CORS configuration
- Static website hosting
- Management policies and lifecycle rules
- Blob inventory policies
- Local users and SFTP
- Encryption scopes
- Comprehensive monitoring and logging

**Prerequisites:**
- Azure subscription with appropriate permissions
- Terraform 1.0 or later
- Azure CLI configured

**Usage:**
```bash
cd examples/advanced
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

## Configuration Files

### Basic Examples
- `main.tf` - Main configuration file with specific feature demonstration

### Advanced Example
- `main.tf` - Main configuration file with comprehensive storage account setup
- `variables.tf` - Variable definitions
- `terraform.tfvars.example` - Example variable values (copy to `terraform.tfvars`)

## Use Case Scenarios

### Development and Testing
- **Basic Example**: Quick setup for development environments
- **Basic with Containers**: Application data storage setup
- **Basic with Queues**: Message queuing for applications
- **Basic Static Website**: Frontend hosting for development

### Production Workloads
- **Basic with Network Rules**: Secure production storage
- **Basic Premium Storage**: High-performance production workloads
- **Basic with Lifecycle Policy**: Cost-optimized production storage
- **Advanced Example**: Enterprise-grade storage with all features

### Specific Use Cases
- **File Shares**: Shared storage for teams and applications
- **Static Website**: Web hosting without servers
- **Network Rules**: Compliance and security requirements
- **Lifecycle Policy**: Data retention and cost management

## Customization

All examples can be customized by modifying the variable values. The advanced example provides a `terraform.tfvars.example` file that you can copy to `terraform.tfvars` and modify according to your needs.

### Key Customization Points

1. **Storage Account Name**: Must be globally unique and 3-24 characters
2. **Resource Group**: Create or use an existing resource group
3. **Location**: Choose an Azure region that supports your required features
4. **Account Tier**: Standard (general purpose) or Premium (high performance)
5. **Replication**: Choose based on your availability and cost requirements
6. **Security**: Configure network rules, encryption, and access controls
7. **Features**: Enable only the features you need (HNS, SFTP, etc.)

## Security Considerations

### Basic Security (All Examples)
- **HTTPS Only**: Enforces HTTPS traffic
- **TLS 1.2**: Uses minimum TLS 1.2 for security
- **Private Containers**: Default to private access

### Enhanced Security (Network Rules Example)
- **Private Network Access**: Storage account is configured for private access only
- **Network Rules**: Restricts access to specific IP ranges and virtual networks
- **OAuth Authentication**: Defaults to Azure AD authentication

### Enterprise Security (Advanced Example)
- **Customer Managed Keys**: Uses Azure Key Vault for encryption key management
- **Private Endpoints**: Secure access through virtual networks
- **Comprehensive Monitoring**: Logging and metrics for security auditing

## Cost Optimization

Consider the following for cost optimization:

1. **Account Tier**: Use Standard tier unless you need Premium features
2. **Replication**: LRS is the most cost-effective option
3. **Access Tier**: Use Cool tier for infrequently accessed data
4. **Lifecycle Management**: Configure policies to move data to cheaper tiers
5. **Retention Policies**: Set appropriate retention periods

## Performance Considerations

### Standard Tier
- Suitable for most workloads
- Cost-effective for general purpose storage
- Supports all storage services

### Premium Tier
- High-performance workloads
- Low-latency requirements
- Large file shares
- Infrastructure encryption

## Cleanup

To destroy the resources created by these examples:

```bash
terraform destroy
```

**Warning**: This will permanently delete all resources created by the example. Make sure you have backups of any important data.

## Troubleshooting

### Common Issues

1. **Storage Account Name Already Exists**: Choose a unique name
2. **Insufficient Permissions**: Ensure your Azure account has the necessary permissions
3. **Feature Not Available in Region**: Some features may not be available in all regions
4. **Key Vault Access**: Ensure the storage account has access to the Key Vault
5. **Network Rules**: Verify IP addresses and virtual network configurations
6. **Premium Tier Limitations**: Premium tier has specific replication and feature limitations

### Getting Help

- Check the [Azure Storage documentation](https://docs.microsoft.com/en-us/azure/storage/)
- Review the [Terraform Azure provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- Check the main module README for detailed parameter descriptions
- Review the specific example README files for targeted guidance 