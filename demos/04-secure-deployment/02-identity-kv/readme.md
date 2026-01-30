# Identities & Key Vault

### Microsoft 365 SharePoint and Teams WebPart Deployment using Key Vault

> Note: This demo is based on the app registration created in the previous [demo](/demos/03-release-strategy/01-release-pipelines/02-deployment-job/02-app-deployment/create-m365-app-registration.azcli).

- Create KeyVault using `create-vault.azcli`

- [spfx-ci-cd-kv.yml](/.azdo/spfx-ci-cd-kv.yml) now uses a Key Vault task to fetch secrets from Key Vault during deployment
