# .NET Build & Deployment using GitHub Actions

Demonstrates multi-job build and deployment of a .NET Web API to Azure App Service using GitHub Actions. The workflow uses artifact sharing between jobs and workload identity federation for secure, credential-free authentication to Azure.

## Demo Overview

1. **Build Job**
   - Checks out code and sets up .NET 10 runtime
   - Publishes the project in Release configuration to a shared build artifact
   - The artifact path is exposed as a job output for downstream consumption by the deploy job

2. **Deploy Job**
   - Downloads the artifact from the build job
   - Authenticates to Azure using workload identity federation (OIDC) with `Azure/login@v2`
   - Deploys the artifact to Azure App Service using `Azure/webapps-deploy@v3`
   - Cleans up Azure CLI session after deployment

## Key Features

- **Separated build and deploy jobs**: Enables parallel execution and clear separation of concerns
- **Workload identity federation**: Uses OpenID Connect tokens for secure, keyless authentication instead of credentials
- **Artifact sharing**: Build output flows through GitHub Actions artifacts, avoiding re-cloning and rebuilding
- **Conditional permissions**: Deploy job only requests `id-token` and `contents` permissions as needed

## Workflow Configuration

```yaml
name: Catalog Service CI/CD

on:
  workflow_dispatch:

env:
  DOTNET_VERSION: "10.0.x"
  PROJECT_PATH: src/services/catalog-service/api/catalog-service.csproj
  BUILD_OUTPUT: ${{ github.workspace }}/build-output

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    outputs:
      artifact-path: ${{ steps.publish.outputs.artifact-path }}

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-dotnet@v4
        with:
          dotnet-version: ${{ env.DOTNET_VERSION }}
      - run: dotnet publish ${{ env.PROJECT_PATH }} --configuration Release --output ${{ env.BUILD_OUTPUT }}
      - uses: actions/upload-artifact@v4
        with:
          name: catalog-api-build
          path: ${{ env.BUILD_OUTPUT }}
          retention-days: 7

  deploy:
    name: Deploy
    needs: build
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/download-artifact@v4
        with:
          name: catalog-api-build
          path: ${{ env.BUILD_OUTPUT }}
      - uses: Azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      - uses: Azure/webapps-deploy@v3
        with:
          app-name: catalog-api-gh-actions-dev
          package: ${{ env.BUILD_OUTPUT }}
      - run: az logout
```

## Links & Resources

[Manually running a workflow](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow)

[Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

[Azure Web Apps Deploy Action](https://github.com/Azure/webapps-deploy)
