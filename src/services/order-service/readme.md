# Order Service - Docker Build with Azure Artifacts Authentication

## Scenario

This .NET service depends on a private NuGet package (`food-app-common`) hosted in Azure Artifacts feed `food-packages`. Building the Docker image requires authenticating to this private feed during `dotnet restore`.

## Solution

The dockerfile uses the **Azure Artifacts Credential Provider** with the `VSS_NUGET_ACCESSTOKEN` environment variable. This approach works identically for both local development and CI/CD pipelines:

- **Locally**: Pass your Personal Access Token (PAT) as a build argument
- **Pipeline**: Azure DevOps automatically provides `System.AccessToken` for authentication

## Local Build

### Prerequisites

**Option 1: Automated (Recommended)**

Run the provided script to create a PAT token automatically:

```powershell
.\get-pat.ps1
```

The script will authenticate with Azure CLI and create a 90-day PAT token with Packaging scope.

**Option 2: Manual**

Create a PAT in Azure DevOps:

- Azure DevOps → User Settings → Personal Access Tokens → New Token
- Scopes: Packaging (Read)

### Build Command

```bash
docker build --rm -f dockerfile -t order-service . --build-arg PAT=<YOUR_PAT_TOKEN>
```

### Run Container

```bash
docker run -it --rm -p 5051:8080 order-service
```

Access the service at `http://localhost:5051`

## Pipeline Build

**Pipeline**: `.azdo/orders-ci-docker-img.yml`

### What It Does

1. **Authenticates to Azure Artifacts** - `NuGetAuthenticate@1` task sets up credentials on the host agent
2. **Logs into Azure Container Registry** - Authenticates to ACR using service connection `scACR`
3. **Builds & Pushes Image** - Executes Docker build in ACR with `System.AccessToken` passed as build argument

### Key Features

- **No secrets in code** - Pipeline token is automatically injected by Azure DevOps
- **ACR Task execution** - Build happens in Azure Container Registry (serverless)
- **Private feed access** - Credential provider handles authentication during `dotnet restore`

### Trigger

Manual trigger only (`trigger: none`) - run from Azure DevOps UI when needed.
