# Terraform Introduction

Terraform is HashiCorp's infrastructure as code (IaC) tool that enables you to define, version, and manage cloud infrastructure declaratively. By using Terraform with Azure Pipelines, you can automate infrastructure provisioning, validate configurations before deployment, and maintain consistent state across environments. This demo integrates Terraform with Azure DevOps using Workload Identity Federation for secure, keyless authentication.

## What It Demonstrates

This demo shows how to build infrastructure as code using Terraform executed from an Azure DevOps pipeline. The [catalog-ci-cd-terraform.yml](/.azdo/catalog-ci-cd-terraform.yml) pipeline orchestrates a complete workflow: building the .NET Catalog API service, running Terraform plan to preview infrastructure changes, then applying the configuration to provision App Service infrastructure in Azure.

## Infrastructure Configuration

The [main.tf](/infra/terraform/main.tf) file demonstrates key Terraform patterns for Azure deployments:

```hcl
terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true # Enable OIDC for Workload Identity Federation
}

# App Service Plan (Linux)
resource "azurerm_service_plan" "main" {
  name                = "terraform-plan-${random_integer.suffix.result}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"
}

# Linux Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_service_name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      dotnet_version = "10.0"
    }
  }
}
```

**Notable patterns:**

- **OIDC Authentication** — Uses `use_oidc = true` with Azure DevOps Workload Identity Federation for secure, keyless authentication without storing secrets
- **Parameterized variables** — Takes subscription ID, resource group, location, and app service name as input variables for multi-environment deployments
- **Random naming** — Generates unique resource names using random suffix to prevent collisions across deployments
- **Consistent tagging** — All resources tagged with Environment, ManagedBy (Terraform), and Purpose for organization and cost tracking
- **Explicit outputs** — Exports webapp URL and resource group name for downstream pipeline steps

## Pipeline Orchestration

The [catalog-ci-cd-terraform.yml](/.azdo/catalog-ci-cd-terraform.yml) pipeline demonstrates infrastructure automation integrated with application build:

**Stage 1: Build** — Compiles the .NET Catalog API service using a reusable build template.

**Stage 2: Terraform Plan** — Validates configuration and previews changes:

- Runs `terraform init` to initialize the working directory
- Runs `terraform validate` to check syntax
- Runs `terraform plan` to generate execution plan
- Publishes the plan artifact for review before apply

**Stage 3: Terraform Apply** — Applies infrastructure changes:

- Downloads build artifacts from the Build stage
- Runs `terraform apply` to provision App Service and plan in Azure
- Deploys the compiled .NET application to the provisioned App Service

Pipeline uses Azure DevOps environment gates: the Apply stage depends on Terraform Plan completion and can include approval gates before executing infrastructure changes.

## Key Benefits

**Infrastructure as Code** — Terraform definitions live in Git, enabling code review, audit trails, version control, and rollback capability.

**State Management** — Terraform maintains state file tracking which resources exist, enabling safe incremental updates and destroying resources when removed from code.

**Plan Before Apply** — `terraform plan` previews all changes before execution, preventing unexpected resource modifications or deletion.

**Reusability** — Same Terraform configuration works across dev, staging, and production by changing input variables.

**No Secrets** — Workload Identity Federation eliminates need to store Azure credentials in Azure DevOps—authentication happens via OIDC with federated identity.

**Consistency** — Infrastructure defined once in code produces identical environments every time it runs, eliminating manual Azure Portal operations.

## Links & Resources

[Terraform documentation](https://www.terraform.io/docs)

[Azure Provider for Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

[Terraform starter for Azure Pipelines](https://github.com/microsoft/terraform-azure-devops-starter/tree/master)

[Provision infrastructure in Azure Pipelines using Terraform](https://docs.microsoft.com/en-us/learn/modules/provision-infrastructure-azure-pipelines/)

[Automating infrastructure deployments in the Cloud with Terraform and Azure Pipelines](https://www.azuredevopslabs.com/labs/vstsextend/terraform/)

[Terraform State Management](https://www.terraform.io/docs/language/state/index.html)
