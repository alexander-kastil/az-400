# Azure DevOps Pipelines

This directory contains 50+ Azure DevOps pipeline definitions demonstrating CI/CD patterns across multiple technology stacks and deployment scenarios.

## Pipelines by Module

Pipelines are named using module prefixes (e.g., `02-02`, `03-02`) that align with the AZ-400 certification curriculum. The naming convention is `<module>-<demo>-<description>`.

|                                                                              |                                                                                         |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| [02-02-angular-ci](angular-ci.yml)                                           | Builds Angular application with unit tests and produces build artifacts                 |
| [02-02-catalog-ci](catalog-ci.yml)                                           | Simple .NET Catalog API CI pipeline with build and publish steps                        |
| [02-02-angular-ci-docker-img](angular-ci-docker-img.yml)                     | Containerizes Angular application and pushes image to Azure Container Registry          |
| [02-02-payment-func-py-ci](payment-func-py-ci.yml)                           | Builds and tests Python Azure Functions with dependency validation                      |
| [02-02-payment-func-py-docker-img](payment-func-py-docker-img.yml)           | Builds Docker image for Python Azure Function and pushes to ACR                         |
| [02-02-python-mcp-ci](python-mcp-ci.yml)                                     | CI pipeline for Python MCP projects with testing and artifact generation                |
| [02-02-react-ci](react-ci.yml)                                               | Builds React application with linting, testing, and artifact creation                   |
| [02-02-spring-ci](spring-ci.yml)                                             | Builds Spring Java applications with Maven and produces deployment artifacts            |
| [02-04-af-students-ai-ci-docker-img](af-students-ai-ci-docker-img.yml)       | Azure Functions Students AI Docker image build and ACR push                             |
| [02-04-blob-console-ci-docker-img](blob-console-ci-docker-img.yml)           | Containerizes Spring Java blob console and publishes to container registry              |
| [02-04-catalog-ci-docker-img](catalog-ci-docker-img.yml)                     | Docker image build for .NET Catalog API and container registry push                     |
| [02-04-food-shop-ci-docker-img](food-shop-ci-docker-img.yml)                 | Containerizes Angular food shop application with optimized build layers                 |
| [02-04-order-processor-java-docker-img](order-processor-java-docker-img.yml) | Containerizes Java order processor service and publishes to container registry          |
| [02-04-payment-func-py-ci-cd-aca](payment-func-py-ci-cd-aca.yml)             | Python Azure Functions CI/CD with containerization and Container Apps deployment        |
| [02-04-react-ci-docker-img](react-ci-docker-img.yml)                         | Docker image build for React application with multi-stage optimization                  |
| [02-06-spfx-ci](spfx-ci.yml)                                                 | SharePoint Framework basic CI pipeline with build and validation steps                  |
| [03-01-angular-unittest](angular-unittest.yml)                               | Angular unit testing with Karma and code coverage reporting                             |
| [03-01-catalog-cd-aca-task](catalog-cd-aca-task.yml)                         | Deploys .NET Catalog API to Azure Container Apps using task-based approach              |
| [03-01-catalog-unittest](catalog-unittest.yml)                               | .NET unit testing pipeline with xUnit and coverage validation                           |
| [03-02-angular-ci-cd-aca](angular-ci-cd-aca.yml)                             | Builds Angular container image and deploys to Azure Container Apps                      |
| [03-02-angular-ci-cd-swa](angular-ci-cd-swa.yml)                             | CI/CD pipeline deploying Angular UI to Azure Static Web Apps                            |
| [03-02-catalog-api-ci-cd](catalog-ci-cd.yml)                                 | Complete CI/CD for .NET Catalog API with build, test, and App Service deployment        |
| [03-02-catalog-ci-cd-aca](catalog-ci-cd-aca.yml)                             | Builds .NET API Docker image and deploys to Azure Container Apps                        |
| [03-02-spfx-ci-cd-template](spfx-ci-cd.yml)                                  | SharePoint Framework CI/CD with template-based packaging and deployment                 |
| [03-02-utils-func-node-ci-cd](utils-func-node-ci-cd.yml)                     | CI/CD for Node.js utility functions with testing and Azure Functions deployment         |
| [03-03-azure-load-test-cd](azure-load-test-cd.yml)                           | Load testing pipeline executing JMeter tests and analyzing performance metrics          |
| [03-03-catalog-api-ci-unittest-template](catalog-ci-unittest-template.yml)   | Unit testing pipeline for .NET Catalog API using reusable templates                     |
| [03-03-react-playwright-e2e](react-playwright-e2e.yaml)                      | End-to-end testing with Playwright for cross-browser user interaction validation        |
| [03-03-react-unittest](react-unittest.yml)                                   | React unit testing with Vitest framework and coverage reporting                         |
| [04-01-blue-green-react-aca](blue-green-react-aca.yaml)                      | Blue-Green deployment with traffic switching for zero-downtime releases                 |
| [04-02-spfx-ci-cd-kv](spfx-ci-cd-kv.yml)                                     | SharePoint Framework deployment with Key Vault integration for secure secret management |
| [04-03-catalog-ci-cd-app-cfg](catalog-ci-cd-app-cfg.yml)                     | .NET API CI/CD with Azure App Configuration integration for dynamic settings            |
| [05-01-catalog-iac-cli](catalog-iac-cli.yml)                                 | Infrastructure provisioning for message queues using Azure CLI                          |
| [05-01-catalog-provision-ci-cd-cli](catalog-provision-ci-cd-cli.yml)         | Infrastructure provisioning using Azure CLI with IaC patterns                           |
| [05-02-catalog-ci-cd-bicep](catalog-ci-cd-bicep.yml)                         | Complete CI/CD with Bicep infrastructure as code for resource provisioning              |
| [05-02-food-app-iac](food-app-iac.yml)                                       | Complete food app infrastructure setup with Bicep for App Service and databases         |
| [05-03-catalog-ci-cd-terraform](catalog-ci-cd-terraform.yml)                 | CI/CD pipeline using Terraform for cloud infrastructure deployment                      |
| [06-02-catalog-ci-mend](catalog-ci-mend.yml)                                 | Security and compliance pipeline with Mend (formerly WhiteSource) dependency scanning   |
| [06-02-react-ci-mend](react-ci-mend.yml)                                     | React application CI with Mend security scanning for vulnerable dependencies            |
| [06-03-catalog-ci-sonar-cloud](catalog-ci-sonar-cloud.yml)                   | Code quality pipeline integrating SonarCloud for static code analysis                   |
| [07-01-food-app-common-ci-cd-artifacts](food-app-common-ci-cd-artifacts.yml) | Shared artifacts pipeline for food application common dependencies                      |
| [07-02-orders-ci](orders-ci.yml)                                             | Builds orders microservice with unit tests and artifact staging                         |
| [07-02-orders-ci-docker-img](orders-ci-docker-img.yml)                       | Containerizes orders microservice and publishes to container registry                   |

## Pipelines Without Module Prefix

These pipelines either have generic names or alternative naming patterns:

- [catalog-cd-environment-gate](catalog-cd-environment-gate.yml) - Environment gate demo

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
