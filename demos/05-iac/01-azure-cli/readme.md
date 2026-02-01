# Infrastructure as Code with Azure CLI

Azure CLI provides a command-line interface for declaratively provisioning and managing Azure resources. By scripting resource creation, you define your infrastructure in code, enabling reproducible deployments, version control, and automation throughout your DevOps pipeline. Azure CLI supports bash, PowerShell, and batch scripting, making it flexible for diverse environments.

## What It Demonstrates

This demo shows how to build infrastructure as code using bash scripts executed from an Azure DevOps pipeline. The [catalog-provision-ci-cd-cli.yml](/.azdo/catalog-provision-ci-cd-cli.yml) pipeline orchestrates a multi-stage workflow: building the .NET Catalog API service, then running the [create-api.sh](infra/cli/create-api.sh) infrastructure script to provision App Service plans and web apps.

## Infrastructure Script

The [create-api.sh](infra/cli/create-api.sh) script demonstrates key Azure CLI patterns:

```bash
env=$1
app=$2
appPlan=foodplan-$env
loc=westeurope
grp=az400-$env

# Create resource group
az group create -n $grp -l $loc

# Create App Service plan
az appservice plan create -n $appPlan -g $grp --sku FREE

# Create web app with .NET 10 runtime
az webapp create -n $app -g $grp --plan $appPlan --runtime "dotnet:10"
```

**Notable patterns:**

- **Parameterized naming** — Takes environment and app name as arguments for flexible deployments
- **Consistent resource group** — All resources grouped by environment for easy management and cleanup
- **Simple provisioning** — Sequential creation of plan then web app with explicit dependency
- **Reusable script** — Same script used across environments by varying arguments

## Pipeline Orchestration

The [catalog-provision-ci-cd-cli.yml](/.azdo/catalog-provision-ci-cd-cli.yml) pipeline demonstrates infrastructure automation integrated with application build:

**Stage 1: Build and Provision** — Runs in parallel:

- **Build job** — Compiles the .NET Catalog API service using reusable build template
- **Provision job** — Runs the Azure CLI script using the `AzureCLI@2` task to create App Service infrastructure

**Stage 2: Deploy** — Depends on Build and Provision completion, then deploys the compiled application to the provisioned App Service.

Pipeline jobs in the first stage run in parallel when possible: build and provision happen simultaneously, then the deploy stage waits for both to complete before deploying the application.

## Key Benefits

**Version Control** — Infrastructure definitions live in Git, enabling code review, audit trails, and rollback capability.

**Reproducibility** — Same script produces identical environments across dev, staging, and production.

**Automation** — Remove manual Azure Portal operations; deploy infrastructure on-demand as part of CI/CD.

**Parameterization** — Pass environment names, sizes, and locations as arguments for flexible, reusable scripts.

**Query Integration** — Extract resource properties (endpoints, keys, URLs) for use in downstream steps.

## Tools & Resources

[Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest) — Complete command reference and task examples.

[Azure CLI Query Language](https://docs.microsoft.com/en-us/cli/azure/query-azure-cli?view=azure-cli-latest) — Learn JMESPath syntax for filtering and transforming output.

[Azure Cloud Shell Tools](https://docs.microsoft.com/en-us/azure/cloud-shell/features) — Bash and PowerShell in your browser with pre-installed Azure CLI.

[Azure CLI Tools VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli) — Syntax highlighting and IntelliSense for Azure CLI scripts.

[Control Azure Services with the CLI](https://docs.microsoft.com/en-us/learn/modules/control-azure-services-with-cli/) — Microsoft Learn module covering Azure CLI fundamentals.
