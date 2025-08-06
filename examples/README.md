# Azure Storage Account Module Examples

This directory contains working examples of the Azure Storage Account Terraform module.

## Examples Overview

### [Basic Example](./basic/)
Minimal storage account configuration for development and testing environments.

**Features:**
- Standard storage account with default settings
- Basic blob containers for data and logs
- HTTPS-only traffic enforcement
- TLS 1.2 minimum version
- Public network access enabled

**Use Cases:**
- Development environments
- Proof of concept deployments
- Learning and testing
- Simple applications with basic storage needs

### [Advanced Example](./advanced/)
Production-ready storage account with comprehensive security and compliance features.

**Features:**
- Premium storage account with ZRS replication
- Customer-managed encryption keys
- Network access restrictions
- Hierarchical namespace for Data Lake Gen2
- Lifecycle management policies
- Blob inventory for compliance
- Local users for SFTP access
- Multiple storage services (blob, queue, table, file)
- Comprehensive monitoring and logging

**Use Cases:**
- Production workloads
- Compliance requirements (SOX, HIPAA, etc.)
- High-performance applications
- Big data and analytics workloads
- Multi-service storage requirements

## Running the Examples

1. **Navigate to the example directory:**
   ```bash
   cd examples/basic  # or examples/advanced
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review the plan:**
   ```bash
   terraform plan
   ```

4. **Apply the configuration:**
   ```bash
   terraform apply
   ```

5. **Clean up resources:**
   ```bash
   terraform destroy
   ```

## Prerequisites

- Terraform ~> 1.13.0
- Azure CLI configured with appropriate permissions
- Azure subscription with sufficient quota

## Notes

- Storage account names must be globally unique across Azure
- Some features require specific Azure regions
- Customer-managed keys require Key Vault access
- Network restrictions may affect connectivity during testing

## Customization

These examples can be customized by:
- Modifying variable values
- Adding or removing storage services
- Adjusting security settings
- Changing resource names and tags
- Adding additional Azure resources as needed 