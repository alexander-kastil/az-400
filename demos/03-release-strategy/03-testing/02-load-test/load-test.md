# Azure Load Testing - Implementation Plan

## Overview

This document outlines the implementation plan for automating Azure Load Testing for the `prime-service` using Azure Pipelines. The goal is to eliminate local execution and leverage Azure resources for building, deploying, and load testing the service.

## Current State

- Manual execution using `create-prime-service.azcli` script
- Local JMeter installation required
- Manual deployment to Azure Container Apps
- Manual upload of JMeter test plan to Azure Load Testing

## Target State

- Automated CI/CD pipeline (`azure-load-test-cd.yml`)
- Container image built in Azure Container Registry (ACR)
- Automated deployment to Azure Container Apps
- Automated load testing using Azure Load Testing service
- No local execution required

## Architecture Components

### Azure Resources

- **Resource Group**: `az400-dev`
- **Azure Container Registry**: `az400acrdev`
- **Azure Container Apps Environment**: `az400acaenv`
- **Container App**: `prime-service-dev`
- **Azure Load Testing**: `az400-load-test` (or existing instance)
- **Service Connection**: `wi-az400-dev` (Workload Identity)

### Source Components

- **Service**: `src/services/prime-service`
- **Dockerfile**: `src/services/prime-service/dockerfile`
- **JMeter Test**: `demos/03-release-strategy/03-testing/02-load-test/test-prime-service.jmx`
- **Pipeline**: `.azdo/azure-load-test-cd.yml`

## Implementation Steps

### Step 1: Create Pipeline YAML

Create `.azdo/azure-load-test-cd.yml` with the following stages:

1. **Build Stage**: Build container image using ACR
2. **Deploy Stage**: Deploy to Azure Container Apps
3. **Load Test Stage**: Execute load test using Azure Load Testing

### Step 2: Build Container Image

- Use Azure CLI task to build image in ACR
- Command: `az acr build --image prime-service --registry az400acrdev --file dockerfile .`
- Working directory: `src/services/prime-service`
- No local Docker required

### Step 3: Deploy to Azure Container Apps

- Fetch ACR credentials
- Create or update Container App with the new image
- Configure:
  - Target port: 8080
  - Ingress: external
  - Environment: `az400acaenv`
- Capture the Container App URL for testing

### Step 4: Update JMeter Test Plan

- Update `test-prime-service.jmx` with placeholder for dynamic URL
- Use variable substitution in pipeline to inject actual URL
- Or use Azure Load Testing parameter override

### Step 5: Execute Load Test

- Use Azure Load Testing task or Azure CLI
- Upload JMeter test plan
- Configure test parameters:
  - Engine instances: 1
  - Duration: 60 seconds (configurable)
- Wait for test completion
- Publish test results

### Step 6: Configure Pipeline Trigger

Options:

- Manual trigger (trigger: none)
- On-demand via Azure DevOps UI
- Scheduled trigger for regular testing
- PR trigger for performance validation

## Pipeline Variables

```yaml
variables:
  acrName: "az400acrdev"
  image: "az400acrdev.azurecr.io/prime-service"
  app: "prime-service-dev"
  grp: "az400-dev"
  serviceConnection: "wi-az400-dev"
  acaenv: "az400acaenv"
  targetPort: 8080
  loadTestResource: "az400-load-test"
  testFile: "demos/03-release-strategy/03-testing/02-load-test/test-prime-service.jmx"
```

## Azure CLI Commands Reference

### Build Image in ACR

```bash
az acr build \
  --image prime-service \
  --registry az400acrdev \
  --file dockerfile \
  .
```

### Get ACR Credentials

```bash
az acr credential show \
  -n az400acrdev \
  -g az400-dev \
  --query passwords[0].value \
  -o tsv
```

### Deploy Container App

```bash
az containerapp create \
  -n prime-service-dev \
  -g az400-dev \
  --image az400acrdev.azurecr.io/prime-service \
  --environment az400acaenv \
  --target-port 8080 \
  --ingress external \
  --registry-username az400acrdev \
  --registry-password <password> \
  --registry-server az400acrdev.azurecr.io
```

### Get Container App URL

```bash
az containerapp show \
  -n prime-service-dev \
  -g az400-dev \
  --query properties.configuration.ingress.fqdn \
  -o tsv
```

## Benefits of Pipeline Approach

1. **Consistency**: Same environment for every build and test
2. **Automation**: No manual steps required
3. **Scalability**: Easy to run multiple tests or test variations
4. **Traceability**: Full audit trail in pipeline history
5. **Integration**: Can be part of PR validation or release gates
6. **Cost Optimization**: Resources created on-demand, can be cleaned up automatically
7. **Team Collaboration**: No local setup required for team members

## Testing the Pipeline

### Manual Execution

1. Navigate to Azure DevOps Pipelines
2. Select `azure-load-test-cd.yml`
3. Click "Run pipeline"
4. Monitor the execution
5. Review load test results in Azure Portal

### Validation Checklist

- [ ] Container image built successfully in ACR
- [ ] Container App deployed and accessible
- [ ] Load test executed successfully
- [ ] Test results available in Azure Load Testing
- [ ] Pipeline completes without errors
- [ ] Container App responds correctly under load

## Future Enhancements

1. **Performance Thresholds**: Add pass/fail criteria based on response time
2. **Multi-Region Testing**: Test from multiple Azure regions
3. **Baseline Comparison**: Compare results with previous runs
4. **Auto-Scaling Validation**: Test auto-scaling behavior under load
5. **Cleanup Stage**: Delete resources after testing (for cost optimization)
6. **Notification**: Send results to Teams/Slack
7. **Dashboard**: Create custom dashboard for trend analysis

## Troubleshooting

### Common Issues

- **ACR Authentication**: Verify service connection has ACR permissions
- **Container App Creation**: Ensure environment exists
- **Load Testing**: Verify JMeter test plan is valid
- **URL Resolution**: Ensure correct FQDN is passed to load test

### Debugging

- Enable verbose logging in Azure CLI tasks
- Check Container App logs for runtime issues
- Review load test logs in Azure Portal
- Validate JMeter test plan locally first (if needed)

## References

- [Azure Load Testing Documentation](https://learn.microsoft.com/en-us/azure/load-testing/)
- [Azure Container Apps Documentation](https://learn.microsoft.com/en-us/azure/container-apps/)
- [Azure DevOps Load Testing Task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/)
- [JMeter Documentation](https://jmeter.apache.org/usermanual/index.html)

## Implementation Status

- [x] Documentation created
- [x] Pipeline YAML created (`.azdo/azure-load-test-cd.yml`)
- [x] JMeter test plan updated (`test-prime-service-parameterized.jmx`)
- [ ] Pipeline tested
- [ ] Results validated

## Files Created

1. **`.azdo/azure-load-test-cd.yml`** - Complete Azure DevOps pipeline with:
   - Build stage: Builds container image in ACR
   - Deploy stage: Deploys to Azure Container Apps
   - Load Test stage: Executes load tests
   - Cleanup stage: Optional resource cleanup

2. **`test-prime-service-parameterized.jmx`** - Parameterized JMeter test plan supporting:
   - Dynamic webapp URL configuration
   - Configurable thread count
   - Configurable ramp-up time
   - Configurable test duration
   - Response assertion for 200 OK

3. **`load-test.md`** - This implementation plan document

4. **Updated `readme.md`** - Enhanced documentation with both automated and manual approaches

## Next Steps

To test the implementation:

1. **Verify Azure Resources**

   ```bash
   # Check if resources exist
   az group show -n az400-dev
   az acr show -n az400acrdev -g az400-dev
   az containerapp env show -n az400acaenv -g az400-dev
   ```

2. **Run the Pipeline**
   - Navigate to Azure DevOps
   - Go to Pipelines
   - Select "New Pipeline" or find `azure-load-test-cd.yml`
   - Run the pipeline

3. **Monitor Execution**
   - Watch build stage for image creation
   - Verify deployment to Container Apps
   - Check smoke test results
   - Review load test output

4. **Validate Results**
   - Verify container app is accessible
   - Test API endpoint manually
   - Check Azure Load Testing results (if configured)

5. **Optional: Configure Azure Load Testing Integration**
   - Create Azure Load Testing resource if needed
   - Uncomment `AzureLoadTest@1` task in pipeline
   - Update `loadTestResource` variable
   - Re-run pipeline with full integration
