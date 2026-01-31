# Build an image and deploy it to a Kubernetes cluster using Azure DevOps pipelines

Demonstrates building containerized applications and deploying them to Kubernetes clusters using Azure DevOps pipelines. The pipelines automate Docker image building, pushing to Azure Container Registry (ACR), and rolling out updates to Kubernetes deployments.

## Demo Overview

### API Pipeline

**Pipeline**: [api-build-deploy-k8s.yml](https://github.com/alexander-kastil/food-app/blob/master/az-pipelines/api-build-deploy-k8s.yml)

**Setup Prerequisites**:

Create a service connection to Azure Container Registry (ACR) for image push operations

Create a Kubernetes resource in the `foodapp-staging` environment with implicit Kubernetes Service Connection

![Kubernetes resource configuration in Azure DevOps environment](_images/resource.png)

**Key features**:

- Builds Docker image from .NET API source code
- Pushes image to ACR with automatic tagging
- Deploys to Kubernetes cluster using kubectl apply
- Targets the `foodapp-staging` environment for staging deployments

### UI Pipeline

**Pipeline**: [ng-build-deploy-k8s.yml](https://github.com/alexander-kastil/food-app/blob/master/az-pipelines/ng-build-deploy-k8s.yml)

**Key features**:

- Builds Angular UI application with production optimizations
- Containerizes the built application in a Docker image
- Pushes image to ACR for registry storage
- Deploys to Kubernetes cluster using infrastructure-as-code manifests

## Execution

Run the pipelines from Azure DevOps to automatically build, containerize, and deploy both services to the Kubernetes cluster.

## Links & Resources

[Azure Container Registry Documentation](https://learn.microsoft.com/azure/container-registry/)

[Azure Pipelines Kubernetes Tasks](https://learn.microsoft.com/azure/devops/pipelines/tasks/deploy/kubernetes-manifest)

[Kubernetes Deployment Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
