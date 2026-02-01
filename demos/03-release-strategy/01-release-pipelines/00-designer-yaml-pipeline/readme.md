# Designer & YAML based Release pipeline

## Demos

Execute [create-catalog-api.azcli](../create-catalog-api.azcli) to provision Azure App Service instances for Dev and Staging environments.

Import and examine [Catalog-Multistage-Release.json](Catalog-Multistage-Release.json), a multi-stage release definition that demonstrates environment progression. Deploys to Dev and Staging using the Azure App Service Deploy task with environment-specific variables for web app names.

Compare with YAML-based approach using deployment jobs and environments for the same release workflow.

## Links & Resources

[Agent Demands](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/demands?view=azure-devops)
