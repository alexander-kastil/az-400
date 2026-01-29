# Terraform Introduction

## Demos

- Show [catalog-ci-cd-terraform.yml](/.azdo/catalog-ci-cd-terraform.yml) - Modern pipeline with Workload Identity Federation
- Show [main.tf](/infra/terraform/main.tf) - Infrastructure configuration with OIDC authentication
- Import pipeline using deployment metadata from [deploy.json](/.github/skills/import-pipeline/deploy.json)

## Pipeline Structure

1. **Build** - .NET application build
2. **Terraform Plan** - `terraform init/validate/fmt/plan`
3. **Terraform Apply** - Infrastructure provisioning
4. **Deploy** - Application deployment to App Service

## Additional Resources

[Terraform starter for Azure Pipelines](https://github.com/microsoft/terraform-azure-devops-starter/tree/master)

[Provision infrastructure in Azure Pipelines using Terraform](https://docs.microsoft.com/en-us/learn/modules/provision-infrastructure-azure-pipelines/)

[Automating infrastructure deployments in the Cloud with Terraform and Azure Pipelines](https://www.azuredevopslabs.com/labs/vstsextend/terraform/)
