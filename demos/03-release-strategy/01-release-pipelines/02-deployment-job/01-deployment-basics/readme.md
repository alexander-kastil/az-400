# Deployment Jobs, Gates & Environments

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