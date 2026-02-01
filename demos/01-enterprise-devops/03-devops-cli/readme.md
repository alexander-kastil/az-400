# Azure DevOps CLI

## Demos

**Install Azure DevOps CLI Extension** — Add the official Azure DevOps extension to enable command-line management of Azure DevOps resources. This provides programmatic access to boards, pipelines, repositories, and more.

```bash
az extension add --name azure-devops
```

**Configure Default Organization and Project** — Set default values for organization and project to simplify subsequent commands, eliminating the need to specify these parameters each time. This improves command brevity and reduces configuration overhead.

```bash
az devops configure --defaults organization=https://dev.azure.com/integrationsonline project=az-400
```

**Query Work Items** — Retrieve work item details from Azure Boards using the command line. Useful for automation, scripting, and integration with external systems.

```bash
az boards work-item show --id 1486
```

## Links & Resources

[az devops](https://docs.microsoft.com/en-us/cli/azure/devops?view=azure-cli-latest)

[Azure DevOps CLI Examples](https://docs.microsoft.com/en-us/azure/devops/cli/quick-reference?view=azure-devops)
