# Azure DevOps Pipelines

This directory contains 50+ Azure DevOps pipeline definitions demonstrating CI/CD patterns across multiple technology stacks and deployment scenarios.

## Copilot Skills & Agent

### Copilot Skills

**import-pipeline**: Automates the import of pipeline YAML files to Azure DevOps using deployment metadata from `.github/deploy.json`. It handles pipeline creation, execution, and error diagnosis all in one command. Example: "Import the catalog-ci-cd.yml pipeline and run it for me."

Sample `.github/deploy.json`:

```json
{
    "Service Connection": "my-service-connection",
    "Git Repo Url": "https://github.com/myusername/my-repo",
    "GitHub Service Connection ID": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "ADOOrg": "https://dev.azure.com/myorgname",
    "ADOProject": "my-project",
    "AzureContainerAppsEnvironment": "my-aca-env",
    "AzureContainerRegistry": "myacrname",
    "DockerRegistry": "my-docker-registry-connection"
}
```

**get-pipeline-logs**: Retrieves logs from the latest Azure DevOps pipeline run with automatic run ID detection. Useful for troubleshooting failures when you need to see detailed task output. Example: "Get the logs from the latest catalog-ci-cd pipeline run."

### Azure DevOps Agent

The **AzDevOps** agent provides specialized Azure DevOps pipeline expertise. It writes YAML pipelines following Microsoft Learn best practices, imports pipelines to Azure DevOps, runs them, troubleshoots failures, and manages service connections. The agent automatically retrieves configuration (org, project, service connections) from Copilot memory, saving setup time. Use it for: creating new pipelines, diagnosing pipeline failures, managing workload identity service connections, and importing complex multi-stage pipelines.

## Pipelines by Module

Pipelines are named using module prefixes (e.g., `02-02`, `03-02`) that align with the AZ-400 certification curriculum. The naming convention is `<module>-<demo>-<description>`.

|                                                                              |                                                                                         |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| [02-02-angular-ci](angular-ci.yml)                                           | Builds Angular application with unit tests and produces build artifacts                 |
| [02-02-angular-ci](angular-ci-docker-img.yml)                                | Containerizes Angular application and pushes image to Azure Container Registry          |
| [02-02-payment-func-py-ci](payment-func-py-ci.yml)                           | Builds and tests Python Azure Functions with dependency validation                      |
| [02-02-payment-func-py-docker-img](payment-func-py-docker-img.yml)           | Builds Docker image for Python Azure Function and pushes to ACR                         |
| [02-02-python-mcp-ci](python-mcp-ci.yml)                                     | CI pipeline for Python MCP projects with testing and artifact generation                |
| [02-02-react-ci](react-ci.yml)                                               | Builds React application with linting, testing, and artifact creation                   |
| [02-02-spring-ci](spring-ci.yml)                                             | Builds Spring Java applications with Maven and produces deployment artifacts            |
| [02-04-order-processor-java-docker-img](order-processor-java-docker-img.yml) | Containerizes Java order processor service and publishes to container registry          |
| [02-04-react-ci-docker-img](react-ci-docker-img.yml)                         | Builds Docker image for React application with optimized multi-stage builds             |
| [03-01-catalog-cd-aca-task](catalog-cd-aca-task.yml)                         | Deploys .NET Catalog API to Azure Container Apps using task-based approach              |
| [03-02-angular-ci-cd-aca](angular-ci-cd-aca.yml)                             | Builds Angular container image and deploys to Azure Container Apps                      |
| [03-02-angular-ci-cd-swa](angular-ci-cd-swa.yml)                             | CI/CD pipeline deploying Angular UI to Azure Static Web Apps                            |
| [03-02-angular-unittest](angular-unittest.yml)                               | Runs Angular unit tests with coverage reporting and artifact generation                 |
| [03-02-catalog-api-ci-cd](catalog-ci-cd.yml)                                 | Complete CI/CD for .NET Catalog API with build, test, and App Service deployment        |
| [03-02-catalog-cd-aca](catalog-cd-aca.yml)                                   | CD pipeline deploying .NET Catalog API container to Azure Container Apps                |
| [03-02-catalog-ci-cd-aca](catalog-ci-cd-aca.yml)                             | Builds .NET API Docker image and deploys to Azure Container Apps                        |
| [03-02-spfx-ci-cd-template](spfx-ci-cd.yml)                                  | SharePoint Framework CI/CD with template-based packaging and deployment                 |
| [03-02-utils-func-node-ci-cd](utils-func-node-ci-cd.yml)                     | CI/CD for Node.js utility functions with testing and Azure Functions deployment         |
| [03-02-catalog-ci-cd-workload-identity](catalog-ci-cd-workload-identity.yml) | CI/CD demonstrating keyless authentication using Azure workload identity federation     |
| [03-03-azure-load-test](azure-load-test-v1.yml)                              | Performance testing pipeline that executes load tests and analyzes results              |
| [03-03-catalog-api-ci-unittest-template](catalog-ci-unittest-template.yml)   | Unit testing pipeline for .NET Catalog API using reusable templates                     |
| [04-02-spfx-ci-cd-kv](spfx-ci-cd-kv.yml)                                     | SharePoint Framework deployment with Key Vault integration for secure secret management |
| [04-03-catalog-api-cicd-appcfg](catalog-ci-cd-app-cfg.yml)                   | .NET API CI/CD with Azure App Configuration integration for dynamic settings            |
| [05-01-catalog-provision-ci-cd-cli](catalog-provision-ci-cd-cli.yml)         | Infrastructure provisioning using Azure CLI with IaC patterns                           |
| [05-02-catalog-ci-cd-bicep](catalog-ci-cd-bicep.yml)                         | Complete CI/CD with Bicep infrastructure as code for resource provisioning              |
| [05-03-catalog-ci-cd-terraform](catalog-ci-cd-terraform.yml)                 | CI/CD pipeline using Terraform for cloud infrastructure deployment                      |
| [06-02-catalog-ci-mend](catalog-ci-mend.yml)                                 | Security and compliance pipeline with Mend (formerly WhiteSource) dependency scanning   |
| [06-02-react-ci-mend](react-ci-mend.yml)                                     | React application CI with Mend security scanning for vulnerable dependencies            |
| [06-03-catalog-ci-sonar-cloud](catalog-ci-sonar-cloud.yml)                   | Code quality pipeline integrating SonarCloud for static code analysis                   |
| [07-01-food-app-common-ci-cd-artifacts](food-app-common-ci-cd-artifacts.yml) | Shared artifacts pipeline for food application common dependencies                      |
| [07-02-orders-ci](orders-ci.yml)                                             | Builds orders microservice with unit tests and artifact staging                         |
| [07-02-orders-ci-docker-img](orders-ci-docker-img.yml)                       | Containerizes orders microservice and publishes to container registry                   |
| [02-04-payment-func-py-ci-cd-aca](payment-func-py-ci-cd-aca.yml)             | Python Azure Functions CI/CD with containerization and Container Apps deployment        |

## Pipelines Without Module Prefix

These pipelines either have generic names or alternative naming patterns:

- [catalog-api-ci-cd-mi](catalog-ci-cd-workload-identity.yml) - Alternative naming for workload identity demo
- [catalog-build-docker-img](catalog-ci-docker-img.yml) - Docker image build pipeline
- [catalog-ci](catalog-ci.yml) - Managed pool CI pipeline
- [catalog-ci](catalog-ci-managed-pool.yml) - Catalog CI on managed pool
- [catalog-ci-unittest-deploy](catalog-ci-unittest-deploy.yml) - Unit testing with deployment
- [catalog-cd-cd-environment-gate](catalog-cd-cd-work-item-gate.yml) - Environment gate demo
- [Deploy UI to Static Website](food-shop-ci-cd-static-webapp.yml) - Static Web Apps deployment
- [docker-ci-img](food-shop-ci-docker-img.yml) - Food shop Docker image build
- [blob-console-img](blob-console-docker-img.yml) - Blob console container image
- [food-app-provision](food-app-provision.yml) - Food app provisioning pipeline
- [provision-azure-cli](provision-azure-cli.yml) - Azure CLI provisioning template
- [provision-bicep-aca-env](provision-acaenv-bicep.yml) - Container Apps environment provisioning
- [react-unittest](react-unittest.yml) - React unit testing pipeline
- [react-ci-docker-img](react-ci-docker-img.yml) - React Docker image with alternate naming
- [spfx-ci](spfx-ci.yml) - Basic SharePoint Framework CI
- [sk-build-docker-img](af-studentsai-docker-img.yml) - AI students project Docker image
- [blue-green-react-aca](blue-green-react-aca.yaml) - React deployment with blue-green strategy
- [react-playwright-e2e](react-playwright-e2e.yaml) - End-to-end testing with Playwright

## Template Directory

The `templates/` subdirectory contains reusable pipeline templates for common tasks:

- Docker image building and pushing
- Container Apps deployment
- Artifact management
- Testing and validation

## Links & Resources

[Azure Pipelines Documentation](https://learn.microsoft.com/azure/devops/pipelines/)

[Pipeline YAML Schema](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema)

[Azure DevOps CLI Reference](https://learn.microsoft.com/azure/devops/cli/)
