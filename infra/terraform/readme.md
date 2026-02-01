# Terraform Infrastructure Configuration

This directory contains Terraform configuration for deploying Azure resources as part of the AZ-400 training pipeline.

## Overview

The Terraform configuration creates:

- Azure App Service Plan (Linux, S1 SKU)
- Azure Linux Web App for .NET 10.0 applications
- Uses existing `az400-dev` resource group

## Configuration Files

- `main.tf` - Main Terraform configuration with provider, resources, and outputs

## Variables

| Variable              | Description           | Default                                |
| --------------------- | --------------------- | -------------------------------------- |
| `subscription_id`     | Azure subscription ID | `cd091145-5ea2-4703-ba5d-41063b1d4308` |
| `resource_group_name` | Resource group name   | `az400-dev`                            |
| `location`            | Azure region          | `westeurope`                           |
| `app_service_name`    | App Service name      | `catalog-service-terraform`            |

## Authentication

The configuration uses **Workload Identity Federation (OIDC)** for secure authentication:

- Set `use_oidc = true` in the AzureRM provider
- Pipeline sets required environment variables:
  - `ARM_CLIENT_ID` - Service principal/managed identity client ID
  - `ARM_TENANT_ID` - Azure AD tenant ID
  - `ARM_SUBSCRIPTION_ID` - Target subscription ID
  - `ARM_USE_OIDC` - Enable OIDC authentication
  - `ARM_OIDC_TOKEN` - OIDC token from Azure DevOps

## Usage

### In Pipeline

The pipeline uses Terraform commands directly (not tasks):

**Plan Stage:**

```bash
terraform init
terraform validate
terraform fmt -check
terraform plan -out=tfplan \
  -var="app_service_name=catalog-service-terraform" \
  -var="resource_group_name=az400-dev" \
  -var="location=westeurope"
```

**Apply Stage:**

```bash
terraform init
terraform apply -auto-approve tfplan
terraform output -raw webapp_name
```

### Local Development

1. Ensure Azure CLI is authenticated:

   ```bash
   az login
   az account set --subscription cd091145-5ea2-4703-ba5d-41063b1d4308
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Plan changes:

   ```bash
   terraform plan
   ```

4. Apply configuration:
   ```bash
   terraform apply
   ```

## Best Practices Implemented

✅ **Workload Identity Federation** - Uses OIDC instead of client secrets  
✅ **Parameterized Configuration** - Variables for all configurable values  
✅ **Latest Provider Versions** - azurerm ~> 4.27, random ~> 3.7  
✅ **Data Sources** - Uses existing resource group instead of creating new  
✅ **Outputs** - Exports webapp name and URL for downstream use  
✅ **Tagging** - Consistent tags for resource management  
✅ **Linux Containers** - Modern Linux-based App Service  
✅ **Version Constraints** - Terraform >= 1.9 requirement

## Pipeline Structure

The associated pipeline ([`catalog-ci-cd-terraform.yml`](../../.azdo/catalog-ci-cd-terraform.yml)) follows this structure:

1. **Build Stage** - Builds .NET application using template
2. **Terraform Plan Stage** - Runs terraform plan and publishes artifacts
3. **Terraform Apply Stage** - Applies infrastructure changes with approval
4. **Deploy Stage** - Deploys application to provisioned App Service

## Notes

- The pipeline uses service connection `wi-az400-dev` for authentication
- Terraform state is stored locally by default
- For production, consider [Azure Storage backend](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage) for remote state
- Format check (`terraform fmt -check`) enforces consistent formatting
