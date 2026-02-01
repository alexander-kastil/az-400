# Using Bicep in Azure DevOps Pipelines

Bicep is a domain-specific language (DSL) for Azure Resource Manager that simplifies infrastructure as code with cleaner syntax compared to ARM JSON templates. Integrating Bicep with Azure DevOps pipelines enables declarative infrastructure provisioning with version control, parameterization, and modular reusable templates. These demos show two different patterns: a complete multi-service application setup and a simple catalog API deployment.

## Catalog API CI/CD with Bicep

The [catalog-ci-cd-bicep.yml](/.azdo/catalog-ci-cd-bicep.yml) pipeline demonstrates infrastructure automation integrated with .NET application build and deployment.

**Pipeline stages:**

**Stage 1: Build** — Compiles the .NET Catalog API service using a reusable build template and produces deployment artifacts.

**Stage 2: Provision** — Deploys the [webapp-windows.bicep](infra/bicep/webapp-windows.bicep) template using the `AzureWebApp@2` task:

- Creates App Service Plan with configurable SKU (Free tier by default)
- Provisions Windows App Service for hosting .NET applications
- Uses parameterized template to support multiple environments by changing variables

**Stage 3: Deploy** — Depends on Provision completion with approval gate, then deploys the compiled .NET application to the provisioned App Service.

The [webapp-windows.bicep](infra/bicep/webapp-windows.bicep) template demonstrates core Bicep patterns:

```bicep
param webAppName string = 'webapp-bicep'
param sku string = 'F1'
param runtimeStack string = 'DOTNET|8.0'
param location string = resourceGroup().location

var appServicePlanName = toLower('appService-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'windows'
}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      windowsFxVersion: runtimeStack
    }
  }
}
```

**Notable patterns:**

- **Parameterized templates** — Takes app name, SKU, and runtime stack as parameters for flexible multi-environment deployments
- **Readable syntax** — Bicep's cleaner DSL compared to ARM JSON: no brackets or escaping required
- **Local variables** — Uses `var` to compute derived names like app service plan name from base app name
- **Resource dependencies** — App Service explicitly references App Service Plan via `serverFarmId` property
- **Symbolic references** — Uses `.id` to reference resource IDs—Bicep resolves dependencies automatically

---

## Food App Multi-Service Infrastructure Setup

The [food-app-iac.yml](/.azdo/food-app-iac.yml) pipeline demonstrates complete infrastructure provisioning for a distributed application using modular Bicep templates.

**Pipeline stages:**

**Stage 1: Provision** — Orchestrates infrastructure setup in two steps:

1. **Fetch secrets** — Uses `AzureKeyVault@1` task to retrieve ACR credentials (username/password) stored in Azure Key Vault
2. **Deploy infrastructure** — Runs `az deployment group create` with the [food-app.bicep](infra/bicep/food-app.bicep) template, passing ACR credentials and container image names as parameters

The [food-app.bicep](infra/bicep/food-app.bicep) template demonstrates enterprise-scale infrastructure patterns:

```bicep
param appName string
param rgLocation string = resourceGroup().location
param acaEnvName string
param acrName string
@secure()
param acrPwd string
param catalogName string
param catalogImage string

module logWS 'modules/log-analytics.bicep' = {
  name: '${appName}logs'
  params: {
    location: rgLocation
    name: '${appName}logs'
  }
}

module containerAppEnvironment 'modules/aca-env.bicep' = {
  name: 'container-app-environment'
  params: {
    name: acaEnvName
    location: rgLocation
    logsCustomerId: logWS.outputs.customerId
    logsPrimaryKey: logWSInstance.listKeys().primarySharedKey
  }
}

module catalogApi 'modules/container-app.bicep' = {
  name: catalogName
  params: {
    name: catalogName
    location: rgLocation
    containerAppEnvironmentId: containerAppEnvironment.outputs.id
    containerImage: '${acrName}.azurecr.io/${catalogImage}:latest'
    useExternalIngress: true
    registry: acrName
  }
}
```

**Notable patterns:**

- **Modular composition** — Uses Bicep modules to compose Log Analytics, App Insights, Container App Environment, and individual container apps
- **Module outputs** — References outputs from modules (e.g., `logWS.outputs.customerId`) to wire dependent resources
- **Secure parameters** — Uses `@secure()` decorator on ACR password to mask sensitive values in logs
- **Key Vault integration** — Pipeline fetches secrets from Key Vault before passing them to Bicep parameters
- **Container registry** — Supports private container images from Azure Container Registry with authentication
- **Cross-module dependencies** — Container App Environment depends on Log Analytics workspace; container apps depend on the environment
- **String interpolation** — Constructs fully qualified image URLs like `${acrName}.azurecr.io/${catalogImage}:latest` directly in parameters

---

## Key Benefits of Bicep in Pipelines

**Declarative Infrastructure** — Define desired state in code; Azure Resource Manager handles create, update, or delete operations.

**Modular templates** — Share and reuse modules across projects for consistent infrastructure patterns (compute, storage, networking).

**Type safety** — Bicep validates syntax and parameter types at template validation time before deployment.

**No Secrets in Code** — Integrate Azure Key Vault in pipeline tasks to retrieve sensitive values (passwords, keys, connection strings) at runtime.

**Environment parity** — Same template with different parameters produces identical infrastructure across dev, staging, and production.

**Version control** — Infrastructure definitions live in Git—all changes auditable with rollback capability.

## Links & Resources

[Bicep Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

[Bicep CLI commands](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-cli)

[Integrate Bicep with Azure Pipelines](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines)

[Bicep Modules](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules)

[Define Resources in Bicep](https://learn.microsoft.com/en-us/azure/templates/)

[Learn modules for Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/learn-bicep)
