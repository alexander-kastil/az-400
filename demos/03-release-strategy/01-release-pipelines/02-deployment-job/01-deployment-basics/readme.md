# Deployment Jobs, Templates, Gates & Environments

## Demos

- Show Gates in Designer based Pipelines

- Gates & Environments Basics

  ![gate](_images/gate.jpg)

  ![approval](_images/approval.jpg)

- Explain `/deploy/az-pipelines/catalog-api-cicd-gates.yml` from [food-app](https://github.com/alexander-kastil/food-app)

  ```yaml
  jobs:
      - deployment: DeployAppService
      displayName: Deploy to prod Appservice
      environment: catalog-api-production
      strategy:
          runOnce:
  ```

## Links & Resources

[Deployment jobs](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/deployment-jobs?view=azure-devops)

[Templates](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops)
