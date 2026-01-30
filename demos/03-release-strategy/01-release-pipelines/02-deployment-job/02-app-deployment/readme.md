# App Deployment

- Show [catalog-ci-cd.yml](/.azdo/catalog-ci-cd.yml) pipeline that deploys the catalog service to Azure App Service.

- Show [spfx-ci-cd.yml](/.azdo/spfx-ci-cd.yml) pipeline that deploys the SPFx app to SharePoint Online App Catalog. Run [create-m365-app-registration.azcli](demos/03-release-strategy/01-release-pipelines/02-deployment-job/02-app-deployment/create-m365-app-registration.azcli) once to register the Entra app and grant Microsoft Graph + SharePoint permissions required for the pipeline’s M365 login and App Catalog upload.

> Note: The SPFx deployment is an outdated pattern and has been updated in SPFx 1.21 and does not use Gulp tasks anymore. Still it demonstrates how to deploy an app using a CLI. We will use Key Vault to store the app registration secret in the pipeline.
