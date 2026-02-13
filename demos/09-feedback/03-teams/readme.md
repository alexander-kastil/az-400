# Microsoft Teams & GitHub Integration

[Join the Microsoft 365 Developer Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program)

[Use the Azure Boards app in Microsoft Teams](https://docs.microsoft.com/en-us/azure/devops/boards/integrations/boards-teams?view=azure-devops)

[Use Azure Pipelines with Microsoft Teams](https://docs.microsoft.com/en-us/azure/devops/pipelines/integrations/microsoft-teams)

[GitHub & Teams](https://github.com/integrations/microsoft-teams)

## Demos

### Azure Boards

Install App Azure Boards

Link your Azure Boards project to the Azure Boards app:

```
@azure boards link [project url]
@azure boards link https://dev.azure.com/integrationsonline/az-400
```

Subscribe to Azure Board Status Change:

```
@azure boards subscriptions
```

### Azure Pipelines

Install Azure Pipelines App

Add pipeline [api-build-provision-deploy-cli.yml](https://github.com/alexander-kastil/food-app/blob/master/az-pipelines/api-build-provision-deploy-cli.yml) and create service connection

Start monitoring all pipelines in project

```
@azure pipelines subscribe https://dev.azure.com/myorg/myproject/
@azure pipelines subscribe https://dev.azure.com/integrationsonline/az-400
```

Show Approval, Run the pipeline in Azure Devops
