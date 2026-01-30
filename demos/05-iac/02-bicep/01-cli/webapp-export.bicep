param serverfarms_appservice_bicep_site_24185_name string
param serverfarms_appservice_bicep_site_name string
param sites_bicep_site_24185_name string

resource serverfarms_appservice_bicep_site_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  kind: 'linux'
  location: 'West Europe'
  name: serverfarms_appservice_bicep_site_name
  properties: {
    elasticScaleEnabled: false
    freeOfferExpirationTime: '2024-10-07T06:51:07.4666667'
    hyperV: false
    isSpot: false
    isXenon: false
    maximumElasticWorkerCount: 1
    perSiteScaling: false
    reserved: true
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    capacity: 1
    family: 'B'
    name: 'B1'
    size: 'B1'
    tier: 'Basic'
  }
}

resource serverfarms_appservice_bicep_site_24185_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  kind: 'linux'
  location: 'West Europe'
  name: serverfarms_appservice_bicep_site_24185_name
  properties: {
    elasticScaleEnabled: false
    hyperV: false
    isSpot: false
    isXenon: false
    maximumElasticWorkerCount: 1
    perSiteScaling: false
    reserved: true
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    capacity: 1
    family: 'B'
    name: 'B1'
    size: 'B1'
    tier: 'Basic'
  }
}

resource sites_bicep_site_24185_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  kind: 'app,linux'
  location: 'West Europe'
  name: sites_bicep_site_24185_name
  properties: {
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    containerSize: 0
    customDomainVerificationId: '1387F783D35B4E628CFECBEF659048D3844B3364AFAB806A32607A7B0D3AA59F'
    dailyMemoryTimeQuota: 0
    dnsConfiguration: {}
    enabled: true
    hostNameSslStates: [
      {
        hostType: 'Standard'
        name: '${sites_bicep_site_24185_name}.azurewebsites.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Repository'
        name: '${sites_bicep_site_24185_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
      }
    ]
    hostNamesDisabled: false
    httpsOnly: false
    hyperV: false
    isXenon: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    redundancyMode: 'None'
    reserved: true
    scmSiteAlsoStopped: false
    serverFarmId: serverfarms_appservice_bicep_site_24185_name_resource.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      functionAppScaleLimit: 0
      http20Enabled: false
      linuxFxVersion: 'DOTNET|8.0'
      minimumElasticInstanceCount: 0
      numberOfWorkers: 1
    }
    storageAccountRequired: false
    vnetBackupRestoreEnabled: false
    vnetContentShareEnabled: false
    vnetImagePullEnabled: false
    vnetRouteAllEnabled: false
  }
}

resource sites_bicep_site_24185_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_bicep_site_24185_name_resource
  location: 'West Europe'
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource sites_bicep_site_24185_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_bicep_site_24185_name_resource
  location: 'West Europe'
  name: 'scm'
  properties: {
    allow: true
  }
}

resource sites_bicep_site_24185_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_bicep_site_24185_name_resource
  location: 'West Europe'
  name: 'web'
  properties: {
    acrUseManagedIdentityCreds: false
    alwaysOn: false
    autoHealEnabled: false
    azureStorageAccounts: {}
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    detailedErrorLoggingEnabled: false
    elasticWebAppScaleLimit: 0
    experiments: {
      rampUpRules: []
    }
    ftpsState: 'FtpsOnly'
    functionsRuntimeScaleMonitoringEnabled: false
    http20Enabled: false
    httpLoggingEnabled: false
    ipSecurityRestrictions: [
      {
        action: 'Allow'
        description: 'Allow all access'
        ipAddress: 'Any'
        name: 'Allow all'
        priority: 2147483647
      }
    ]
    linuxFxVersion: 'DOTNET|8.0'
    loadBalancing: 'LeastRequests'
    localMySqlEnabled: false
    logsDirectorySizeLimit: 35
    managedPipelineMode: 'Integrated'
    minTlsVersion: '1.2'
    minimumElasticInstanceCount: 0
    netFrameworkVersion: 'v4.0'
    numberOfWorkers: 1
    preWarmedInstanceCount: 0
    publishingUsername: '$bicep-site-24185'
    remoteDebuggingEnabled: false
    requestTracingEnabled: false
    scmIpSecurityRestrictions: [
      {
        action: 'Allow'
        description: 'Allow all access'
        ipAddress: 'Any'
        name: 'Allow all'
        priority: 2147483647
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    scmMinTlsVersion: '1.2'
    scmType: 'None'
    use32BitWorkerProcess: true
    virtualApplications: [
      {
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
        virtualPath: '/'
      }
    ]
    vnetPrivatePortsCount: 0
    vnetRouteAllEnabled: false
    webSocketsEnabled: false
  }
}

resource sites_bicep_site_24185_name_sites_bicep_site_24185_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_bicep_site_24185_name_resource
  location: 'West Europe'
  name: '${sites_bicep_site_24185_name}.azurewebsites.net'
  properties: {
    hostNameType: 'Verified'
    siteName: 'bicep-site-24185'
  }
}
