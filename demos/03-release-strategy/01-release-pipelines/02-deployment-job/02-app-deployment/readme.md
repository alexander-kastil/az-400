# App Deployment

## Demos

- [catalog-ci-cd.yml](/.azdo/catalog-ci-cd.yml) demonstrates a pipeline that deploys a .NET catalog service to Azure App Service.

- [spfx-ci-cd.yml](/.azdo/spfx-ci-cd.yml) demonstrates pipeline that deploys the SPFx app to SharePoint Online App Catalog. Run [create-m365-app-registration.azcli](demos/03-release-strategy/01-release-pipelines/02-deployment-job/02-app-deployment/create-m365-app-registration.azcli) once to register the Entra app and grant Microsoft Graph + SharePoint permissions required for the pipeline’s M365 login and App Catalog upload.

  > Note: The SPFx deployment is an outdated pattern and has been updated in SPFx 1.21 and does not use Gulp tasks anymore. Still it demonstrates how to deploy an older app using a CLI. We will use Key Vault to store the app registration secret in the pipeline.

- [angular-ci-cd-swa.yml](/.azdo/angular-ci-cd-swa.yml) demonstrates pipeline that deploys the Angular app to Azure Static Web Apps. It includes a token replacement task to replace variables in the Angular environment.ts file during the build, as well as a manual build. The public folder of the Angular app includes a staticwebapp.config.json file to configure routing for the SPA.

  > Note: Use this link to learn more about the [Token Replacement Task](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens) and make sure to install it in your Azure DevOps organization.
