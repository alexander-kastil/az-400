$grp = "az400-dev"
$loc = "westeurope"
$devOpsOrg = "integrationsonline"
$project = "az-400"
$wfIdentity = "wi-" + $grp
$subscriptionId = "cd091145-5ea2-4703-ba5d-41063b1d4308"
$issuer = "99e5794d-47e1-4b9b-86eb-937aa20e4e11"

$resourceGroupScope = "/subscriptions/$subscriptionId/resourcegroups/$grp"
$federatedCredentialName = "AzureDevOps"
$audience = "api://AzureADTokenExchange"
$issuerUrl = "https://vstoken.dev.azure.com/$issuer"
$subjectIdentifier = "sc://$devOpsOrg/$project/$wfIdentity"
$contributorRoleId = "b24988ac-6180-42a0-ab88-20f7382dd24c"
$orgUrl = "https://dev.azure.com/$devOpsOrg"
$serviceConnectionName = $wfIdentity

az devops configure --defaults organization=$orgUrl project=$project

# Create resource group
az group create -n $grp -l $loc

# Create a managed identity
az identity create --name $wfIdentity --resource-group $grp
$principalId = az identity show --name $wfIdentity --resource-group $grp --query principalId -o tsv

# Get the client id
$clientId = az identity show --name $wfIdentity --resource-group $grp --query clientId -o tsv

# Wait for the service principal backing the managed identity to be available
for ($i = 1; $i -le 10; $i++) {
    $spExists = az ad sp show --id $clientId 2>$null
    if ($spExists) {
        break
    }
    Write-Host "Waiting for service principal propagation... ($i/10)"
    Start-Sleep -Seconds 10
}

# Assign the managed identity the contributor role
for ($i = 1; $i -le 5; $i++) {
    $roleAssignment = az role assignment create --assignee $principalId --role $contributorRoleId --scope $resourceGroupScope 2>$null
    if ($roleAssignment) {
        Write-Host "Role assignment succeeded"
        break
    }
    Write-Host "Retrying role assignment... ($i/5)"
    Start-Sleep -Seconds 5
}

# Azure DevOps service connection (Workload Identity Federation)
$subscriptionName = az account show --subscription $subscriptionId --query name -o tsv
$tenantId = az account show --subscription $subscriptionId --query tenantId -o tsv
$projectId = az devops project show --project $project --query id -o tsv

# Create service connection via REST
$payloadFile = [System.IO.Path]::GetTempFileName()

$payload = @"
{
  "name": "$serviceConnectionName",
  "type": "azurerm",
  "url": "https://management.azure.com/",
  "authorization": {
    "parameters": {
      "serviceprincipalid": "$clientId",
      "tenantid": "$tenantId",
      "scope": "$resourceGroupScope"
    },
    "scheme": "WorkloadIdentityFederation"
  },
  "data": {
    "subscriptionId": "$subscriptionId",
    "subscriptionName": "$subscriptionName",
    "environment": "AzureCloud",
    "scopeLevel": "Subscription",
    "creationMode": "WorkloadIdentityFederation"
  },
  "serviceEndpointProjectReferences": [
    {
      "projectReference": {
        "id": "$projectId",
        "name": "$project"
      },
      "name": "$serviceConnectionName"
    }
  ]
}
"@

$payload | Set-Content -Path $payloadFile -Encoding UTF8

$endpointId = az devops invoke `
  --area serviceendpoint `
  --resource endpoints `
  --route-parameters project=$project `
  --api-version 7.1-preview `
  --in-file $payloadFile `
  --http-method POST `
  --query id -o tsv

Remove-Item $payloadFile

Write-Host "endpointId=$endpointId"
Write-Host "Querying auto-generated issuer and subject..."

# Get the auto-generated issuer and subject from the service connection
$scDetails = az devops invoke `
  --area serviceendpoint `
  --resource endpoints `
  --route-parameters project=$project endpointId=$endpointId `
  --api-version 7.1-preview `
  --http-method GET | ConvertFrom-Json

$actualIssuer = $scDetails.authorization.parameters.workloadIdentityFederationIssuer
$actualSubject = $scDetails.authorization.parameters.workloadIdentityFederationSubject

Write-Host "Azure DevOps generated issuer: $actualIssuer"
Write-Host "Azure DevOps generated subject: $actualSubject"

# Update the federated credential to match Azure DevOps
Write-Host "Updating managed identity federated credential to match..."
az identity federated-credential delete --name $federatedCredentialName --identity-name $wfIdentity --resource-group $grp --yes 2>$null
az identity federated-credential create `
  --name $federatedCredentialName `
  --identity-name $wfIdentity `
  --resource-group $grp `
  --issuer $actualIssuer `
  --subject $actualSubject `
  --audiences $audience | Out-Null

# Share with all pipelines
if ($endpointId) {
    az devops service-endpoint update --id $endpointId --enable-for-all true | Out-Null
    Write-Host "✓ Service connection '$serviceConnectionName' created and shared successfully!"
    Write-Host "✓ Endpoint ID: $endpointId"
    Write-Host "✓ Federated credential updated to match Azure DevOps issuer/subject"
} else {
    Write-Host "Failed to create service connection"
}
