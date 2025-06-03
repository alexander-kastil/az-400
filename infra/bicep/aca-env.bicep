param rgLocation string = resourceGroup().location
param acaEnvName string
param acrName string

module acr 'modules/acr.bicep' = {
  name: acrName
  params: {
    name: acrName
    location: rgLocation
  }
}

module logWS 'modules/log-analytics.bicep' = {
  name: '${acaEnvName}logs'
  params: {
    location: rgLocation
    name: '${acaEnvName}logs'
  }
}

module appInsights 'modules/app-insights.bicep' = {
  name: '${acaEnvName}-app-insights'
  params: {
    rgLocation: rgLocation
    aiName: '${acaEnvName}-app-insights'
    logAnalyticsId: logWS.outputs.id
  }
}

// because we need the primary key for the ACA Environment module, we need to get it from the existing Log Analytics workspace
resource logWSInstance 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${acaEnvName}logs'
  location: rgLocation
}

module containerAppEnvironment 'modules/aca-env.bicep' = {
  name: 'container-app-environment'
  params: {
    name: acaEnvName
    location: rgLocation
    logsCustomerId: logWS.outputs.customerId
    logsPrimaryKey: logWSInstance.listKeys().primarySharedKey // provided the instance we can use functions like listKeys
  }
}
