# Azure Load Test - Working Implementation Analysis

## Original Working Version (commit e13f44c)

### Configuration File: prime-service-loadtest.yaml
```yaml
version: v0.1
testId: prime-service-loadtest
displayName: Prime Service Load Test
description: Load test for prime-service endpoint
testType: JMX
testPlan: demos/03-release-strategy/03-testing/02-load-test/test-prime-service.jmx
engineInstances: 1
```

**Key Points:**
- Uses full relative path: `demos/03-release-strategy/03-testing/02-load-test/test-prime-service.jmx`
- Simple configuration without environment variables in config
- testId used for identification

### Pipeline: azure-load-test.yml - LoadTest Stage

**Key Differences in Original:**

1. **Stage Dependencies with Output Variables:**
```yaml
variables:
  appUrl: $[ stageDependencies.Deploy.DeployApp.outputs['getUrl.appUrl'] ]
```
- Uses stage dependencies to capture URL from Deploy stage
- References the `getUrl` task output

2. **Deploy Stage Task - Get Container App URL:**
```yaml
- task: AzureCLI@2
  displayName: "Get Container App URL"
  inputs:
    azureSubscription: "$(serviceConnection)"
    scriptType: "bash"
    scriptLocation: "inlineScript"
    inlineScript: |
      APP_URL=$(az containerapp show -n $(app) -g $(grp) --query properties.configuration.ingress.fqdn -o tsv)
      echo "Container App URL: https://${APP_URL}"
      echo "##vso[task.setvariable variable=appUrl;isOutput=true]${APP_URL}"
  name: getUrl
```

3. **LoadTest Stage Task - Prepare JMeter:**
```yaml
- task: AzureCLI@2
  displayName: "Update JMeter test with app URL"
  inputs:
    azureSubscription: "$(serviceConnection)"
    scriptType: "bash"
    scriptLocation: "inlineScript"
    inlineScript: |
      echo "App URL: $(appUrl)"
      echo "Test file: $(testFile)"
      cp $(testFile) $(testFile).temp
      echo "JMeter test file prepared"
  name: getUrl
```

4. **Azure Load Test Task - Proper Environment Variable:**
```yaml
- task: AzureLoadTest@1
  displayName: "Execute Azure Load Test"
  inputs:
    azureSubscription: "$(serviceConnection)"
    loadTestConfigFile: "demos/03-release-strategy/03-testing/02-load-test/prime-service-loadtest.yaml"
    resourceGroup: "$(grp)"
    loadTestResource: "$(loadTestResource)"
    env: |
      [
        {
          "name": "webapp",
          "value": "https://$(appUrl)"
        }
      ]
```
- Note: Includes `https://` protocol prefix in the value
- Uses the appUrl variable passed through stage dependencies

5. **Additional Smoke Test:**
```yaml
- task: AzureCLI@2
  displayName: "Smoke Test with curl"
  inputs:
    azureSubscription: "$(serviceConnection)"
    scriptType: "bash"
    scriptLocation: "inlineScript"
    inlineScript: |
      echo "Running smoke test..."
      for i in {1..5}; do
        echo "Request $i:"
        curl -s "https://$(appUrl)/api/primes/10000"
        echo ""
        sleep 1
      done
      echo "Smoke test completed"
```

## Critical Issues in Current Implementation

1. **Stage Dependencies Not Set Up** - The current LoadTest stage doesn't properly reference the appUrl from Deploy stage
2. **Missing name: getUrl** - The "Get Container App URL" task in Deploy stage is missing the `name: getUrl` identifier
3. **No isOutput: true** - The appUrl variable in Deploy stage doesn't set it as an output
4. **Duplicate Task Name** - The "Update JMeter test" task has `name: getUrl` which duplicates the Deploy stage task
5. **Template Usage** - Current implementation uses templates but lost the proper variable passing mechanism

## Build & Deploy Implementation Pattern

Original uses inline AzureCLI steps:
- Build stage: Checks if image exists before building
- Deploy stage: Checks if app exists before deploying
- Uses idempotent patterns to prevent re-creation

Current uses templates which abstract details, but proper variable passing is lost.
