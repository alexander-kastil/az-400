# Secure Deployment

## Demos

| Demo                      | Description                                                                                                                                        |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Blue-Green Deployment** | Two identical environments with instant traffic switching for zero-downtime releases. Enables quick rollback if issues arise.                      |
| **Canary Release**        | Gradual rollout to small user subset before full deployment. Validates changes with real traffic before wider release.                             |
| **Ring-based Deployment** | Staged deployment across rings with progressive traffic increase. Manages risk through phased rollout across environments.                         |
| **Key Vault Integration** | Secure secret storage and management with Azure Key Vault. Pipelines retrieve secrets at runtime with the Azure Key Vault task.                    |
| **Managed Identities**    | Passwordless authentication for Azure services. Eliminates secrets management complexity for service-to-service communication.                     |
| **App Configuration**     | Centralized configuration management with Azure App Configuration. Syncs dynamic settings in CI/CD pipelines for environment-specific deployments. |

## Links & Resources

[Azure Key Vault](https://docs.microsoft.com/de-de/azure/key-vault/general/) — Secure secret storage and management

[Azure Key Vault task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-key-vault?view=azure-devops) — Retrieve secrets in pipelines

[Azure Managed Identities](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/) — Passwordless authentication for Azure services

[Azure App Config](https://docs.microsoft.com/en-us/azure/azure-app-configuration/overview) — Centralized configuration management

[Pull settings to App Configuration with Azure Pipelines](https://docs.microsoft.com/en-us/azure/azure-app-configuration/pull-key-value-devops-pipeline) — Sync configuration in CI/CD

[Deployment Jobs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/deployment-jobs?view=azure-devops) — Define deployment targets and environments

## Additional Labs & Walkthroughs

[Manage secrets in your server apps with Azure Key Vault](https://docs.microsoft.com/en-us/learn/modules/manage-secrets-with-azure-key-vault/) — Microsoft Learn module on Key Vault

[Authenticate apps to Azure services by using service principals and managed identities for Azure resources](https://docs.microsoft.com/en-us/learn/modules/authenticate-apps-with-managed-identities/) — Learn about passwordless authentication

[Implement application configuration](https://docs.microsoft.com/en-us/learn/modules/implement-application-configuration/) — Configure applications with Azure App Configuration
