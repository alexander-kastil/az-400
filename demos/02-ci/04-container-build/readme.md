# Container Continuos Integration

## Links & Resources

[Docker CLI](https://docs.docker.com/engine/reference/commandline/cli/)

[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

[NGINX](https://www.nginx.com/)

[Automate container image builds and maintenance with ACR Tasks](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tasks-overview)

## Demos

| Pipeline                                                                         | Description                                                                     |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| [catalog-docker-img.yml](../../.azdo/catalog-docker-img.yml)                     | Builds Docker image for .NET Catalog API and pushes to Azure Container Registry |
| [catalog-ci-docker-img.yml](../../.azdo/catalog-ci-docker-img.yml)               | Docker image for .NET Catalog API with multi-stage build optimization           |
| [af-students-ai-ci-docker-img.yml](../../.azdo/af-students-ai-ci-docker-img.yml) | Azure Functions Students AI Docker image build and ACR push                     |
| [food-shop-ci-docker-img.yml](../../.azdo/food-shop-ci-docker-img.yml)           | Containerizes Angular food shop application with optimized build layers         |
| [payment-func-py-docker-img.yml](../../.azdo/payment-func-py-docker-img.yml)     | Packages Python Azure Function in Docker image for container deployment         |
| [react-ci-docker-img.yml](../../.azdo/react-ci-docker-img.yml)                   | Docker image for React application with multi-stage optimization                |

## Additional Labs & Walkthroughs

[Automate Docker container deployments with Azure Pipelines](https://docs.microsoft.com/en-us/learn/modules/deploy-docker/)

[Build a docker Image](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/containers/build-image?view=azure-devops)

[Introduction to Kubernetes on Azure](https://docs.microsoft.com/en-us/learn/paths/intro-to-kubernetes-on-azure/)
