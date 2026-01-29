# AZ-400 Training Repository - AI Coding Agent Instructions

This repository contains training materials, demos, and infrastructure for Microsoft AZ-400 (DevOps Solutions) certification. It's a **teaching repository** - not a production application - designed to demonstrate DevOps concepts through hands-on examples.

## Repository Purpose & Structure

**Primary Goal**: Provide instructor-led demos and labs for Azure DevOps, GitHub Actions, IaC, and cloud-native development patterns.

### Key Directories

- **`.azdo/`** - Azure DevOps pipeline definitions (50+ pipelines covering CI/CD patterns)
- **`.github/workflows/`** - GitHub Actions workflows for cross-platform demos
- **`demos/`** - Module-organized demonstrations (8 modules covering entire AZ-400 curriculum)
- **`src/`** - Sample applications (Angular, React, .NET, Python, Java, SPFx)
- **`infra/`** - Infrastructure as Code (Bicep, Terraform, Azure CLI)

### Agents & Skills

#### Agents

- AzDevOps.agent - Specialized AI coding agent for Azure DevOps pipelines and related code.

#### Skills

- .github/skills/import-pipeline/,
- .github/skills/wi-creation

## Critical Configuration Files

### Deployment Metadata (`.github/skills/deploy.json`)

**All pipeline imports require this metadata file:**

```json
{
  "Service Connection": "wi-az400-dev",
  "Git Repo Url": "https://github.com/alexander-kastil/az-400",
  "GitHub Service Connection ID": "231c44ad-d4a9-4055-bca6-40bab720370f",
  "ADOOrg": "https://dev.azure.com/integrationsonline",
  "ADOProject": "az-400"
}
```

**Never hardcode these values** - always read from `deploy.json` when creating/importing pipelines.

### Standard Resource Naming

- **Resource Group**: `az400-dev` (primary), `az400-bash` (Linux demos)
- **ACR**: `az400acrdev`
- **Service Connection**: `wi-az400-dev` (Workload Identity Federation)
- **ACA Environment**: `az400acaenv`

## Pipeline Architecture & Patterns

### Template-Based Design

All pipelines use reusable templates from `.azdo/templates/`:

**Core Templates:**

- `t-build-docker-image.yaml` - Builds images in ACR with existence checks
- `t-deploy-container-app.yaml` - Deploys to Azure Container Apps with create/update logic
- `t-fetch-acr-credentials.yaml` - Securely retrieves ACR credentials
- `t-net-build.yaml` - .NET build with artifact publishing
- `t-spfx-build.yaml` / `t-spfx-deploy-cli.yaml` - SharePoint Framework workflows
- `t-playwright-tests.yaml` - E2E testing template

**Template Parameters Pattern:**
All templates accept `serviceConnection` parameter for workload identity auth. Example:

```yaml
template: templates/t-build-docker-image.yaml
parameters:
  acrName: az400acrdev
  imageName: my-app
  serviceConnection: wi-az400-dev
  override: false  # Skip build if image exists
```

### Pipeline Naming Convention

Format: `<module>-<demo>-<description>` (from YAML `name:` attribute)

- Examples: `03-02-angular-cd-aca`, `02-01-03-pipeline-basics`
- Module numbers align with demos folder structure

### Common Pipeline Stages

1. **Build** - Compile code, run tests, build containers
2. **Deploy** - Deploy to Azure resources (App Service, ACA, Static Web Apps)
3. **Test** - Run smoke/load/E2E tests (Load Test stage uses Azure Load Testing)
4. **Cleanup** - Optional teardown (disabled by default)

## Authentication & Security

### Workload Identity Federation (Preferred)

**All new pipelines must use WIF** instead of service principals with secrets.

**Creation Script**: `demos/03-release-strategy/01-release-pipelines/01-service-connections/create-workload-identity.ps1`

**What it does:**

1. Creates managed identity + resource group
2. Assigns Contributor role with retry logic (eventual consistency)
3. Creates Azure DevOps service connection via REST API
4. Queries auto-generated OIDC issuer/subject from Azure DevOps
5. Syncs federated credentials to match Azure DevOps values
6. Shares connection with all pipelines

**Critical:** You cannot set custom issuer/subject - Azure DevOps generates these. Scripts use a two-phase approach:

1. Create connection (ADO auto-generates values)
2. Query connection to get actual issuer/subject
3. Update federated credential to match

## Application Stack & Technologies

### Multi-Language Support

- **.NET** (Azure Functions, APIs) - See `src/az-functions/`, `src/services/`
- **Angular** - `src/angular/food-shop/` (18.x with standalone components)
- **React** - `src/react/` (Static Web Apps demos)
- **Python** - Azure Functions (`src/az-functions/payment-py/`)
- **Java** - Jobs and services (`src/jobs/blob-java/`)
- **SPFx** - SharePoint Framework (`src/spfx/food-list/`)

### Infrastructure Technologies

- **Bicep** - Modular templates in `infra/bicep/` (preferred for new IaC)
- **Terraform** - `infra/terraform/` (cross-cloud examples)
- **Azure CLI** - `infra/cli/` (scripting demos)

## Build & Test Commands

### .NET Projects

```bash
# Build (from project root like src/az-functions/payment-net/)
dotnet clean
dotnet build --configuration Release
dotnet publish --configuration Release

# Run locally
cd bin/Debug/net10.0
func host start
```

### Angular Projects

```bash
# Build
cd src/angular/food-shop
npm install
npm run build  # Output: dist/food-shop

# Run dev server
npm start  # http://localhost:4200

# E2E tests (Playwright)
npx playwright test
```

### Container Builds

**Never use local Docker** - always build in ACR:

```bash
az acr build \
  --image <repo>:$(Build.BuildId) \
  --image <repo>:latest \
  --registry az400acrdev \
  --file Dockerfile \
  .
```

## Specialized Workflows

### Import Pipeline from YAML

Use skill documented in `.github/skills/import-pipeline/SKILL.md`:

```bash
az pipelines create \
  --name "<name from YAML>" \
  --repository "$(cat .azdo/deploy.json | jq -r '.["Git Repo Url"]')" \
  --repository-type github \
  --branch main \
  --yml-path ".azdo/<pipeline-file>.yml" \
  --service-connection "$(cat .azdo/deploy.json | jq -r '.["GitHub Service Connection ID"]')" \
  --org "$(cat .azdo/deploy.json | jq -r '.ADOOrg')" \
  --project "$(cat .azdo/deploy.json | jq -r '.ADOProject')"
```

### Load Testing Pattern

See `demos/03-release-strategy/03-testing/02-load-test/`:

- Parameterized JMeter test: `test-prime-service-parameterized.jmx`
- Pipeline: `.azdo/azure-load-test.yml`
- Captures Container App URL dynamically
- Injects URL into JMeter via `-Jwebapp` parameter

## Developer Environment Setup

### Prerequisites Installation

Run from **elevated PowerShell**:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/alexander-kastil/az-400/main/setup/setup-az-400.ps1'))
```

Installs: Git, Azure CLI, .NET SDK, Node.js, Docker Desktop, VS Code extensions

### Fork & Clone Workflow

```bash
gh auth login
gh repo fork https://github.com/alexander-kastil/az-400/
gh repo clone https://github.com/<USERNAME>/az-400/
```

## Common Patterns & Conventions

### Pipeline Triggers

**Default**: `trigger: none` (manual execution for teaching)

- Demos use `trigger: none` to prevent accidental runs
- Production would use branch/path filters

### Variable Scopes

Pipelines demonstrate variable precedence:

- Stage-level variables override global
- Job-level variables override stage
- Example: `demos/02-ci/01-pipelines/03-pipeline-syntax/02-03-variables-scopes.yml`

### Conditional Execution

Use expressions for stage/job conditions:

```yaml
condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
```

### Artifact Handling

```yaml
# Publish
- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(Build.ArtifactStagingDirectory)'
    ArtifactName: 'drop'

# Download
- task: DownloadBuildArtifacts@0
  inputs:
    artifactName: 'drop'
    downloadPath: '$(System.ArtifactsDirectory)'
```

## When Adding New Content

1. **New Pipeline**: Use templates from `.azdo/templates/`, set `trigger: none`, add to `.azdo/`
2. **New App**: Place in `src/<category>/`, create Dockerfile, add to `create-images.azcli`

## Common Issues & Solutions

**Problem**: Pipeline fails with "service connection not found"

- **Solution**: Check `deploy.json` has correct service connection name, verify connection exists in ADO

**Problem**: ACR build fails with permissions error

- **Solution**: Ensure service connection has Contributor role on resource group

**Problem**: Container App deploy fails with "environment not found"

- **Solution**: Create ACA environment first: `az containerapp env create -n az400acaenv -g az400-dev`

**Problem**: Federated credential mismatch

- **Solution**: Re-run workload identity script - it queries actual issuer/subject from ADO and syncs
