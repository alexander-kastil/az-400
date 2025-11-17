# Azure Managed DevOps Pools 

Azure DevOps provides a way to manage your agents in pools. This allows you to group agents together and manage them as a single entity.

## Links & Resources

[Managed DevOps Pools](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/overview?view=azure-devops)

[Quickstart: Create a Managed DevOps Pool using the Azure portal](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/quickstart-azure-portal?view=azure-devops)

## Demos 

- Create an [Azure Dev Center](https://learn.microsoft.com/en-us/azure/deployment-environments/how-to-create-configure-dev-center) and register the `Microsoft.DevOpsInfrastructure` provider at subscription level.

- The pool shows up in the Azure DevOps portal under `Project Settings` -> `Agent Pools` und pipelines can be configured to use the pool.

    ![managed-pool](_images/managed-pool-permissions.png)

- Execute `catalog-ci managed-pool.yml` to use the managed pool for your pipeline:

    ```yaml
    trigger: none
    pr: none

    variables:
    buildConfiguration: Release
    appPath: src/services/catalog-service/api/

    pool: az-pool

    stages:
    - stage: "Build"
    ...
    ```    