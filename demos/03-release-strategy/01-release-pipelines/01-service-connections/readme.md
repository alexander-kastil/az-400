# Azure DevOps Service Connections

Demonstrates creating and managing Azure DevOps service connections with Workload Identity Federation (WIF). WIF provides secure, keyless authentication between Azure DevOps pipelines and Azure resources, eliminating the need to manage service principal secrets.

> **Note**: The **create-workload-identity-service-connection** skill provides automated setup. Use it to create service connections through Copilot by asking:
>
> "Create a workload identity service connection for Azure DevOps to authenticate to Azure"
>
> The skill handles federated credential synchronization and role assignments automatically.

## Create Workload Identity Service Connection

Automate secure service connection creation using provided scripts. Both PowerShell and Bash implementations create a managed identity, Azure DevOps service connection with federated credentials, and configure appropriate role assignments.

### PowerShell Automation

Execute [create-workload-identity.ps1](create-workload-identity.ps1) to provision:

```powershell
./create-workload-identity.ps1
```

**Creates**:

- Resource group: `az400-dev`
- Managed identity: `wi-az400`
- Azure DevOps service connection with WIF
- Federated credential linking Azure DevOps to the managed identity
- Contributor role assignment to the resource group

### Bash Automation

Execute [create-workload-identity.sh](create-workload-identity.sh) for cross-platform provisioning:

```bash
bash create-workload-identity.sh
```

**Creates**:

- Resource group: `az400-bash`
- Managed identity: `wi-az400-bash`
- Same service connection and federated credential setup

**Key features**:

- Automatic federated credential sync with Azure DevOps OIDC issuer/subject (two-phase process)
- Retry logic for eventual consistency in service principal propagation
- Shared service connection access to all pipelines
- No secrets stored in Azure DevOps

The created service connection appears in Azure DevOps project settings:

![Service Connection configuration in Azure DevOps](./_images/service-connection.png)

## Delete Workload Identity Service Connection

Clean up resources safely using [delete-workload-identity.ps1](delete-workload-identity.ps1) or [delete-workload-identity.sh](delete-workload-identity.sh). These scripts handle deletion in the correct order:

- Remove federated credential
- Delete service connection
- Revoke role assignments
- Remove managed identity

```powershell
./delete-workload-identity.ps1
```

```bash
bash delete-workload-identity.sh
```

## Using Workload Identity in Pipelines

Reference the service connection in your pipelines using the connection name `scWorkload`. Example usage in a pipeline:

```yaml
variables:
  dotnetSdkVersion: "9.x"
  buildConfiguration: Release
  releaseBranchName: master
  serviceConnection: scWorkload
  appPath: src/services/catalog-service/api/
  appService: food-catalog-api-yaml
```

The pipeline authenticates to Azure automatically using the workload identity federation—no manual secret management required.

## Links & Resources

[Workload Identity Federation](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation)

[Connect to Azure by using an Azure Resource Manager service connection](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)

[Azure DevOps CLI service endpoint](https://learn.microsoft.com/en-us/azure/devops/cli/service-endpoint?view=azure-devops)
