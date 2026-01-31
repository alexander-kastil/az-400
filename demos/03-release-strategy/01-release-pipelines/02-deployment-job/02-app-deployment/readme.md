# App Deployment Samples

| Pipeline | Description |
|----------|-------------|
| [catalog-ci-cd.yml](/.azdo/catalog-ci-cd.yml) | Deploys a .NET WebApi to Azure App Service. |
| [catalog-ci-unittest-template.yml](/.azdo/catalog-ci-unittest-template.yml) | Uses templates for build and unit test jobs. Templates help reuse pipeline code and reduce maintenance effort. |
| [spfx-ci-cd.yml](/.azdo/spfx-ci-cd.yml) | Deploys SPFx app to SharePoint Online App Catalog. Run [create-m365-app-registration.azcli](demos/03-release-strategy/01-release-pipelines/02-deployment-job/02-app-deployment/create-m365-app-registration.azcli) to register the Entra app and grant Microsoft Graph + SharePoint permissions. Stores app registration secret in Key Vault. **Note:** SPFx deployment is outdated; SPFx 1.21+ no longer uses Gulp tasks. |
| [angular-ci-cd-swa.yml](/.azdo/angular-ci-cd-swa.yml) | Deploys Angular app to Azure Static Web Apps with manual build for full control. Includes token replacement to update environment.ts variables and Node package caching. Uses staticwebapp.config.json for SPA routing. **Note:** Requires [Token Replacement Task](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens) installed in Azure DevOps. |
| [payment-func-py-ci-cd.yaml](/.azdo/payment-func-py-ci-cd.yaml) | Python Azure Function deployment using build template for dependency management and AzureCLI for zip-based deployment. Suitable for serverless workloads. |
| [utils-func-node-ci-cd.yml](/.azdo/utils-func-node-ci-cd.yml) | Node.js Azure Function deployment using build template for TypeScript compilation and AzureFunctionApp@2 task for Linux function app deployment. |
