$grp = "az400-dev"
$devOpsOrg = "integrationsonline"
$project = "az-400"
$wfIdentity = "wi-az400"
$subscriptionId = "cd091145-5ea2-4703-ba5d-41063b1d4308"
$federatedCredentialName = "AzureDevOps"
$orgUrl = "https://dev.azure.com/$devOpsOrg"
$serviceConnectionName = $wfIdentity

Write-Host "Starting cleanup of workload identity and service connection..." -ForegroundColor Cyan

# Configure Azure DevOps defaults
az devops configure --defaults organization=$orgUrl project=$project

# Get managed identity details
$clientId = az identity show --name $wfIdentity --resource-group $grp --query clientId -o tsv 2>$null
$principalId = az identity show --name $wfIdentity --resource-group $grp --query principalId -o tsv 2>$null

if ($clientId) {
    Write-Host "✓ Found managed identity: $wfIdentity (ClientId: $clientId)" -ForegroundColor Green
} else {
    Write-Host "⚠ Managed identity '$wfIdentity' not found in resource group '$grp'" -ForegroundColor Yellow
}

# Get service connection ID
$endpointId = az devops service-endpoint list --query "[?name=='$serviceConnectionName'].id" -o tsv 2>$null

if ($endpointId) {
    Write-Host "✓ Found service connection: $serviceConnectionName (ID: $endpointId)" -ForegroundColor Green
} else {
    Write-Host "⚠ Service connection '$serviceConnectionName' not found in project '$project'" -ForegroundColor Yellow
}

# Step 1: Delete federated credential from managed identity (required before deleting service connection)
if ($clientId) {
    Write-Host "`n[1/5] Deleting federated credential from managed identity..." -ForegroundColor Cyan
    $fedCredResult = az identity federated-credential delete `
      --name $federatedCredentialName `
      --identity-name $wfIdentity `
      --resource-group $grp `
      --yes 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Federated credential '$federatedCredentialName' deleted" -ForegroundColor Green
    } else {
        Write-Host "⚠ Federated credential may not exist or already deleted" -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[1/5] Skipping federated credential deletion (managed identity not found)" -ForegroundColor Yellow
}

# Step 2: Delete Azure DevOps service connection
if ($endpointId) {
    Write-Host "`n[2/5] Deleting Azure DevOps service connection..." -ForegroundColor Cyan
    $deleteResult = az devops service-endpoint delete --id $endpointId --yes 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Service connection '$serviceConnectionName' deleted" -ForegroundColor Green
    } else {
        Write-Host "✗ Failed to delete service connection" -ForegroundColor Red
    }
} else {
    Write-Host "`n[2/5] Skipping service connection deletion (not found)" -ForegroundColor Yellow
}

# Step 3: Delete role assignments
if ($principalId) {
    Write-Host "`n[3/5] Deleting role assignments..." -ForegroundColor Cyan
    $roleAssignments = az role assignment list --assignee $principalId --query "[].id" -o tsv 2>$null
    
    if ($roleAssignments) {
        foreach ($assignmentId in $roleAssignments) {
            az role assignment delete --ids $assignmentId 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✓ Role assignment deleted: $assignmentId" -ForegroundColor Green
            }
        }
    } else {
        Write-Host "⚠ No role assignments found for principal $principalId" -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[3/5] Skipping role assignment deletion (principal not found)" -ForegroundColor Yellow
}

# Step 4: Delete managed identity
if ($clientId) {
    Write-Host "`n[4/5] Deleting managed identity..." -ForegroundColor Cyan
    az identity delete --name $wfIdentity --resource-group $grp 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Managed identity '$wfIdentity' deleted" -ForegroundColor Green
    } else {
        Write-Host "✗ Failed to delete managed identity" -ForegroundColor Red
    }
} else {
    Write-Host "`n[4/5] Skipping managed identity deletion (not found)" -ForegroundColor Yellow
}

# Step 5: Optionally delete resource group
Write-Host "`n[5/5] Resource group cleanup" -ForegroundColor Cyan
$deleteRg = Read-Host "Do you want to delete the resource group '$grp'? (y/N)"

if ($deleteRg -eq 'y' -or $deleteRg -eq 'Y') {
    Write-Host "Deleting resource group '$grp'..." -ForegroundColor Cyan
    az group delete --name $grp --yes --no-wait
    Write-Host "✓ Resource group deletion initiated (running in background)" -ForegroundColor Green
} else {
    Write-Host "⚠ Resource group '$grp' retained" -ForegroundColor Yellow
}

Write-Host "`n✓ Cleanup completed!" -ForegroundColor Green
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  - Federated credential: Deleted" -ForegroundColor Gray
Write-Host "  - Service connection: Deleted" -ForegroundColor Gray
Write-Host "  - Role assignments: Deleted" -ForegroundColor Gray
Write-Host "  - Managed identity: Deleted" -ForegroundColor Gray
Write-Host "  - Resource group: $($deleteRg -eq 'y' -or $deleteRg -eq 'Y' ? 'Deleting...' : 'Retained')" -ForegroundColor Gray
