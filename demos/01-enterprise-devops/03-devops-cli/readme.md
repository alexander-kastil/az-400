# Azure DevOps CLI

## Links & Resources

[az devops](https://docs.microsoft.com/en-us/cli/azure/devops?view=azure-cli-latest)

[Azure DevOps CLI Examples](https://docs.microsoft.com/en-us/azure/devops/cli/quick-reference?view=azure-devops)

## Demos

Install Azure DevOps Extension:

```bash
az extension add --name azure-devops
```

```bash
az devops configure --defaults organization=https://dev.azure.com/integrations-development project=az-400
az boards work-item show --id 1486
```