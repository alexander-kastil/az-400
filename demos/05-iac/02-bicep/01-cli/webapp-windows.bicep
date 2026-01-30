param webAppName string = 'webapp-bicep'          // Web app name
param sku string = 'B1'                            // The SKU of App Service Plan
param runtimeStack string = 'DOTNET|8.0'          // The runtime stack of web app
param location string = resourceGroup().location  // Location for all resources

var appServicePlanName = toLower('appService-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: runtimeStack
    }
  }
}
