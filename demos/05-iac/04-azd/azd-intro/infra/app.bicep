// Define parameters that can be passed into the module
// Parameters allow a module to be reusable
@description('The location of where to deploy resources')
param location string

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The name of the App Service')
param appServiceName string

// Define the App Service Plan to manage compute resources
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: 'F1'
  }
  kind: 'linux'
}

// Define the App Service to host the application
resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|10.0'
    }
  }
  // Tag used to reference the service in the Azure.yaml file
  tags: { 'azd-service-name': 'web' }
}
