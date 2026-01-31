# .NET Build & Deployment using GitHub Actions

Demonstrates automated build and deployment of a .NET Web API to Azure App Service using GitHub Actions. The workflow showcases path-based triggers to run only when relevant code changes, combined with manual dispatch capabilities for on-demand execution with custom parameters.

## Demo Overview

1. **Provision Azure App Service** using [provision-catalog-api-webapp.azcli](provision-catalog-api-webapp.azcli)
   - Creates a resource group, app service plan, and web app configured for .NET 10
   - Extracts publishing credentials for secure deployment

2. **Store Publishing Profile in GitHub Secrets**
   - Configure the publishing profile in [GitHub Actions Secrets](https://github.com/alexander-kastil/food-app/settings/secrets/actions)
   - Used for secure authentication to Azure App Service without exposing credentials in workflow

3. **GitHub Actions Workflow: [catalog-api-cicd.yml](https://github.com/alexander-kastil/food-app/blob/master/.github/workflows/catalog-api-cicd.yml)**

   Key features:
   - **Path-based trigger**: Runs only when changes occur in `apps/catalog-api/api/**`
   - **Workflow dispatch**: Manual trigger with input parameters (log level, test tags, target environment)
   - **.NET 8 build pipeline**: Builds and publishes Release configuration
   - **Azure deployment**: Uses `azure/webapps-deploy@v2` action for direct App Service deployment

   ```yaml
   name: catalog-api-cicd

   on:
     push:
       branches:
         - master
       paths:
         - apps/catalog-api/api/**
     workflow_dispatch:
       inputs:
         logLevel:
           description: 'Log level'
           required: true
           default: 'warning'
           type: choice
           options:
             - info
             - warning
             - debug
         tags:
           description: 'Test scenario tags'
           required: false
           type: boolean
         environment:
           description: 'Environment to run tests against'
           type: environment
           required: true

   env:
     Appservice: catalog-api-github-actions

   jobs:
     build-and-deploy:
       runs-on: ubuntu-latest

       steps:
         - uses: actions/checkout@master

         - name: Set up .NET Core
           uses: actions/setup-dotnet@v1
           with:
             dotnet-version: "8.0.x"

         - name: Build with dotnet
           run: dotnet build ${{ github.workspace }}/apps/catalog-api/api/catalog-api.csproj --configuration Release

         - name: dotnet publish
           run: dotnet publish ${{ github.workspace }}/apps/catalog-api/api/catalog-api.csproj -c Release -o ${{env.DOTNET_ROOT}}/api

         - name: Deploy to Azure Web App
           uses: azure/webapps-deploy@v2
           with:
             app-name: ${{ env.Appservice }}
             publish-profile: ${{ secrets.CATALOG_API_PROFILE }}
             package: ${{env.DOTNET_ROOT}}/api
   ```

4. **Run the Workflow**
   - Trigger manually via GitHub Actions or automatically on code push
   - Monitor build and deployment progress in the workflow run logs

## Links & Resources

[Manually running a workflow](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow)

[Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

[Azure Web Apps Deploy Action](https://github.com/Azure/webapps-deploy)
