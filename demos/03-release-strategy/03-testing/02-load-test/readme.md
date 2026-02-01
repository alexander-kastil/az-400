# Load Testing with Azure Load Testing

## Overview

This demo showcases automated load testing for the **Prime Service** — a .NET API that calculates prime numbers up to a given number. The service is containerized, deployed to Azure Container Apps, and stress-tested using Apache JMeter and Azure Load Testing to measure response times and throughput under load.

The Prime Service endpoint returns performance metrics including execution time and the container instance ID:

```c#
[HttpGet]
[Route("{n}")]
public IActionResult Get(int n)
{
    Stopwatch watch = new Stopwatch();
    watch.Start();
    var count = getPrimesCount(n);
    watch.Stop();
    return Ok($"Primes - {count}, Time Taken - {watch.ElapsedMilliseconds}ms, Instance Id - {Environment.GetEnvironmentVariable("WEBSITE_INSTANCE_ID")}");
}
```

## Automated Pipeline Approach (Recommended)

The recommended approach uses an Azure DevOps pipeline for fully automated, repeatable load testing without requiring local dependencies.

### Quick Start

1. **Run the Pipeline**

   ```bash
   # Navigate to Azure DevOps Pipelines
   # Select: .azdo/azure-load-test-cd.yml
   # Click: "Run pipeline"
   ```

2. **Pipeline Stages**
   - **Build**: Container image built in Azure Container Registry (ACR) using `az acr build`
   - **Deploy**: Service deployed to Azure Container Apps
   - **Test**: Smoke tests verify deployment, followed by automated load tests
   - **Cleanup**: Optional resource cleanup (disabled by default)

3. **Key Benefits**
   - ✅ No local setup required (no JMeter installation needed)
   - ✅ Consistent, repeatable test environment
   - ✅ Full integration with CI/CD workflows
   - ✅ Complete audit trail in pipeline execution history
   - ✅ Parallel execution scaling with multiple engine instances

### Pipeline Configuration Details

The [load-test.md](./load-test.md) document provides the complete implementation plan, including architecture components, Azure resource setup, and step-by-step configuration instructions.

## Manual Testing Approach (Original)

For manual testing or local development:

### Prerequisites

For local development or manual testing, you can deploy the service and execute load tests manually using Apache JMeter.

### Prerequisites

Install Apache JMeter and Java:

```powershell
winget install EclipseAdoptium.Temurin.8
winget install ApacheJMeter.ApacheJMeter
```

### Deploy the Service

Deploy the Prime Service to [Azure Container Apps](https://learn.microsoft.com/en-us/azure/container-apps/) using one of these options:

**Option 1: Visual Studio Code**

Use the [Azure Container Apps extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurecontainerapps) to deploy directly from VS Code:

![VS Code Container Apps extension for deploying to Azure Container Apps](_images/code-ext.png)

**Option 2: Azure CLI Script**

Execute the [create-prime-service.azcli](./create-prime-service.azcli) script for automated deployment via CLI.

### Verify Service Deployment

Once deployed, verify the service is accessible:

```bash
curl https://primes-api.kindplant-307af914.westeurope.azurecontainerapps.io/api/primes/10000
```

Replace the URL with your actual container app URL (available from the Container Apps overview page in the Azure Portal).

### Configure and Run Load Tests

#### Parameterized Test Plan (Recommended)

Use [test-prime-service-parameterized.jmx](./test-prime-service-parameterized.jmx) with dynamic parameters passed via command line:

```bash
jmeter -n -t test-prime-service-parameterized.jmx \
  -Jwebapp=your-app.azurecontainerapps.io \
  -Jthreads=250 \
  -Jrampup=30 \
  -Jduration=60
```

This approach eliminates the need to edit XML files for each test run and supports easy parameter variation.

#### Original Test Plan

The [test-prime-service.jmx](./test-prime-service.jmx) file is a standard JMeter test plan with hardcoded configuration. Load it into the JMeter GUI and update the service URL before running:

![JMeter test plan configuration showing HTTP Request samplers and assertions](_images/jmeter.png)

### Run Load Test in Azure Portal

Azure Load Testing provides a managed service for load testing with visual test result analysis:

1. **Create Azure Load Testing Instance**

   Search for "Azure Load Testing" in the Azure Portal and create a new instance:

   ![Azure Load Testing create resource page](_images/load-testing.png)

2. **Upload and Configure Test**

   Create a new test and upload your JMeter script:

   ![Upload JMeter test file dialog](_images/test-1.png)

   Configure test parameters (threads, ramp-up, duration, etc.):

   ![Configure test parameters and load settings](_images/test-2.png)

   Map load test parameters to JMeter variables:

   ![Parameter mapping configuration between Azure Load Testing and JMeter variables](_images/test-3.png)

3. **Execute and Review Results**
   Artifacts

- [test-prime-service.jmx](./test-prime-service.jmx) — Original JMeter test plan with hardcoded service URL (basic approach)
- [test-prime-service-parameterized.jmx](./test-prime-service-parameterized.jmx) — Parameterized JMeter test plan supporting dynamic configuration via CLI arguments
- [create-prime-service.azcli](./create-prime-service.azcli) — Azure CLI script for automated service deployment to Container Apps
- [prime-service-loadtest.yaml](./prime-service-loadtest.yaml) — Azure Load Testing configuration file defining test metadata and JMeter script reference
- [load-test.md](./load-test.md) — Comprehensive implementation guide covering architecture, setup steps, and troubleshooting

## Links & Resources

- [Azure Load Testing Documentation](https://learn.microsoft.com/en-us/azure/load-testing/)
- [Azure Container Apps Documentation](https://learn.microsoft.com/en-us/azure/container-apps/)
- [JMeter Documentation](https://jmeter.apache.org/usermanual/index.html)
