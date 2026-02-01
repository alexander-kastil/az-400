# Provision to Azure Container Apps

Demonstrates deploying containerized applications to Azure Container Apps using Azure DevOps pipelines. Container Apps provides a serverless container platform with built-in support for scaling, networking, and Dapr integration, ideal for microservices and event-driven workloads.

## Environment Setup

Provision the Container Apps environment using [provision-aca-env.azcli](provision-aca-env.azcli):

```bash
env=dev
grp=az400-$env
loc=westeurope
acr=az400acr$env
acaenv=az400acaenv

az group create -n $grp -l $loc
az containerapp env create -n $acaenv -g $grp -l $loc
```

This creates a resource group and Container Apps managed environment for hosting container applications.

## CI/CD Pipelines

|                                                                       |                                                                                                                                                              |
| --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [angular-ci-cd-aca.yml](/.azdo/angular-ci-cd-aca.yml)                 | Angular UI CI/CD pipeline with multi-stage Docker build for optimized image size. Automatically builds and deploys containerized app to Container Apps.      |
| [payment-func-py-ci-cd-aca.yml](/.azdo/payment-func-py-ci-cd-aca.yml) | Python Azure Function containerization and deployment with configurable replica scaling (min/max). Uses reusable template-based build steps for consistency. |

## Links & Resources

[Azure Container Apps Documentation](https://learn.microsoft.com/azure/container-apps/)

[Azure DevOps Pipelines](https://learn.microsoft.com/azure/devops/pipelines/)
