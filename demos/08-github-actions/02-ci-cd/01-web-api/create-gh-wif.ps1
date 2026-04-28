$grp = "az-400"
$subscriptionId = "cd091145-5ea2-4703-ba5d-41063b1d4308"

az account set --subscription $subscriptionId
$miName = "wi-$grp"
$githubOrg = "alexander-kastil"
$githubRepo = "az-400"
$branch = "main"
$contributorRoleId = "b24988ac-6180-42a0-ab88-20f7382dd24c"
$resourceGroupScope = "/subscriptions/$subscriptionId/resourceGroups/$grp"

az identity create --name $miName --resource-group $grp --subscription $subscriptionId

$clientId = az identity show --name $miName --resource-group $grp --subscription $subscriptionId --query clientId -o tsv
$principalId = az identity show --name $miName --resource-group $grp --subscription $subscriptionId --query principalId -o tsv

for ($i = 1; $i -le 10; $i++) {
    $spExists = az ad sp show --id $clientId 2>$null
    if ($spExists) { break }
    Write-Host "Waiting for service principal propagation... ($i/10)"
    Start-Sleep -Seconds 10
}

for ($i = 1; $i -le 5; $i++) {
    $roleAssignment = az role assignment create --assignee $principalId --role $contributorRoleId --scope $resourceGroupScope 2>$null
    if ($roleAssignment) { Write-Host "Role assignment succeeded"; break }
    Write-Host "Retrying role assignment... ($i/5)"
    Start-Sleep -Seconds 5
}

az identity federated-credential create `
    --name "github-actions-$githubRepo" `
    --identity-name $miName `
    --resource-group $grp `
    --issuer "https://token.actions.githubusercontent.com" `
    --subject "repo:${githubOrg}/${githubRepo}:ref:refs/heads/${branch}" `
    --audiences "api://AzureADTokenExchange"

$tenantId = az account show --subscription $subscriptionId --query tenantId -o tsv

Write-Host "Pushing secrets to GitHub..."
gh secret set AZURE_CLIENT_ID --body $clientId --repo "${githubOrg}/${githubRepo}"
gh secret set AZURE_TENANT_ID --body $tenantId --repo "${githubOrg}/${githubRepo}"
gh secret set AZURE_SUBSCRIPTION_ID --body $subscriptionId --repo "${githubOrg}/${githubRepo}"

Write-Host "Done. Managed identity: $miName, clientId: $clientId"
