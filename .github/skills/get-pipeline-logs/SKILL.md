---
name: get-pipeline-logs
description: Retrieve Azure DevOps pipeline logs (list, download specific log, or download all logs) using secure authentication patterns and troubleshooting guidance.
license: MIT
---

# Azure DevOps Pipeline Log Retrieval

This skill retrieves Azure DevOps pipeline logs for a specific run, either by listing log entries, downloading a single log, or downloading all logs as a ZIP. It follows Microsoft Learn guidance for log review and secure authentication.

## Overview

Azure DevOps logs are the primary source for diagnosing pipeline failures. You can view logs in the UI or programmatically access them via REST API. For automation and scripting, use Microsoft Entra ID access tokens when possible and avoid long-lived PATs.

## Prerequisites

- Azure DevOps organization and project
- Build (run) ID for the pipeline
- Authentication:
  - **Preferred:** Microsoft Entra ID access token (service principal or user token)
  - **Pipeline context:** `System.AccessToken` (requires enabling “Allow scripts to access OAuth token”)

## Key Concepts

- **List log entries:** Enumerate log IDs and line counts for a build.
- **Download a log:** Fetch an individual log by `logId`.
- **Download all logs:** Download a ZIP of all build logs.
- **Verbose diagnostics:** Enable `system.debug = true` or “Enable system diagnostics” for detailed logs.

## Best Practices (Microsoft Learn)

- Use **Microsoft Entra ID tokens** over PATs for security.
- Don’t log credentials or tokens.
- Enable **system diagnostics** (`system.debug=true`) when troubleshooting.
- Use HTTPS and pin REST API versions.

## Step-by-Step: Retrieve Logs via REST API

### 1) List log entries for a build

**Request**

```
GET https://dev.azure.com/{org}/{project}/_apis/build/builds/{buildId}/logs?api-version=7.1-preview.2
```

**PowerShell (Entra token via Azure CLI)**

```
$org = "integrationsonline"
$project = "az-400"
$buildId = 160

$token = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv
$headers = @{ Authorization = "Bearer $token" }
$uri = "https://dev.azure.com/$org/$project/_apis/build/builds/$buildId/logs?api-version=7.1-preview.2"

Invoke-RestMethod -Uri $uri -Headers $headers
```

### 2) Download a specific log by `logId`

**Request**

```
GET https://dev.azure.com/{org}/{project}/_apis/build/builds/{buildId}/logs/{logId}?api-version=7.1-preview.2
```

**PowerShell (write to file)**

```
$org = "integrationsonline"
$project = "az-400"
$buildId = 160
$logId = 21

$token = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv
$headers = @{ Authorization = "Bearer $token"; Accept = "text/plain" }
$uri = "https://dev.azure.com/$org/$project/_apis/build/builds/$buildId/logs/$logId?api-version=7.1-preview.2"

Invoke-RestMethod -Uri $uri -Headers $headers -OutFile "$env:TEMP\azdo-build-$buildId-log-$logId.txt"
```

### 3) Download all logs as a ZIP

**Request**

```
GET https://dev.azure.com/{org}/{project}/_apis/build/builds/{buildId}/logs?api-version=7.1-preview.2&`$format=zip
```

**PowerShell**

```
$org = "integrationsonline"
$project = "az-400"
$buildId = 160

$token = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv
$headers = @{ Authorization = "Bearer $token"; Accept = "application/zip" }
$uri = "https://dev.azure.com/$org/$project/_apis/build/builds/$buildId/logs?api-version=7.1-preview.2&`$format=zip"

Invoke-RestMethod -Uri $uri -Headers $headers -OutFile "$env:TEMP\azdo-build-$buildId-logs.zip"
```

## Pipeline-Friendly Auth Patterns

### Use `System.AccessToken` in pipeline steps

**Bash**

```
- bash: |
    az devops configure --defaults organization='$(System.TeamFoundationCollectionUri)' project='$(System.TeamProject)'
    az pipelines runs show --id $(Build.BuildId)
  env:
    AZURE_DEVOPS_EXT_PAT: $(System.AccessToken)
```

**PowerShell**

```
- pwsh: |
    az devops configure --defaults organization='$(System.TeamFoundationCollectionUri)' project='$(System.TeamProject)'
    az pipelines runs show --id $(Build.BuildId)
  env:
    AZURE_DEVOPS_EXT_PAT: $(System.AccessToken)
```

> Note: `System.AccessToken` requires pipeline settings to allow OAuth token access.

## Troubleshooting Tips

- If logs appear truncated, download the ZIP log bundle from the run summary.
- If you need deeper diagnostics, enable `system.debug = true`.
- If REST calls return HTML, verify the request URL and ensure the Authorization header is set.

## References

- Review logs to diagnose pipeline issues
  - https://learn.microsoft.com/en-us/azure/devops/pipelines/troubleshooting/review-logs?view=azure-devops
- REST API samples (authentication best practices)
  - https://learn.microsoft.com/en-us/azure/devops/integrate/get-started/rest/samples?view=azure-devops
- Azure DevOps CLI in YAML (auth options)
  - https://learn.microsoft.com/en-us/azure/devops/cli/azure-devops-cli-in-yaml?view=azure-devops

## License

MIT
