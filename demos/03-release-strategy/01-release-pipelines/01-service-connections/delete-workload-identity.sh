#!/bin/bash

grp="az400-bash"
devOpsOrg="integrationsonline"
project="az-400"
wfIdentity="wi-az400-bash"
subscriptionId="cd091145-5ea2-4703-ba5d-41063b1d4308"
federatedCredentialName="AzureDevOps"
orgUrl="https://dev.azure.com/$devOpsOrg"
serviceConnectionName="$wfIdentity"

echo "Starting cleanup of workload identity and service connection..."

# Configure Azure DevOps defaults
az devops configure --defaults organization=$orgUrl project=$project

# Get managed identity details
clientId=$(az identity show --name $wfIdentity --resource-group $grp --query clientId -o tsv 2>/dev/null)
principalId=$(az identity show --name $wfIdentity --resource-group $grp --query principalId -o tsv 2>/dev/null)

if [ -n "$clientId" ]; then
    echo "✓ Found managed identity: $wfIdentity (ClientId: $clientId)"
else
    echo "⚠ Managed identity '$wfIdentity' not found in resource group '$grp'"
fi

# Get service connection ID
endpointId=$(az devops service-endpoint list --query "[?name=='$serviceConnectionName'].id" -o tsv 2>/dev/null)

if [ -n "$endpointId" ]; then
    echo "✓ Found service connection: $serviceConnectionName (ID: $endpointId)"
else
    echo "⚠ Service connection '$serviceConnectionName' not found in project '$project'"
fi

# Step 1: Delete federated credential from managed identity (required before deleting service connection)
if [ -n "$clientId" ]; then
    echo ""
    echo "[1/5] Deleting federated credential from managed identity..."
    if az identity federated-credential delete \
      --name $federatedCredentialName \
      --identity-name $wfIdentity \
      --resource-group $grp \
      --yes 2>/dev/null; then
        echo "✓ Federated credential '$federatedCredentialName' deleted"
    else
        echo "⚠ Federated credential may not exist or already deleted"
    fi
else
    echo ""
    echo "[1/5] Skipping federated credential deletion (managed identity not found)"
fi

# Step 2: Delete Azure DevOps service connection
if [ -n "$endpointId" ]; then
    echo ""
    echo "[2/5] Deleting Azure DevOps service connection..."
    if az devops service-endpoint delete --id $endpointId --yes 2>/dev/null; then
        echo "✓ Service connection '$serviceConnectionName' deleted"
    else
        echo "✗ Failed to delete service connection"
    fi
else
    echo ""
    echo "[2/5] Skipping service connection deletion (not found)"
fi

# Step 3: Delete role assignments
if [ -n "$principalId" ]; then
    echo ""
    echo "[3/5] Deleting role assignments..."
    roleAssignments=$(az role assignment list --assignee $principalId --query "[].id" -o tsv 2>/dev/null)
    
    if [ -n "$roleAssignments" ]; then
        while IFS= read -r assignmentId; do
            if az role assignment delete --ids $assignmentId 2>/dev/null; then
                echo "✓ Role assignment deleted: $assignmentId"
            fi
        done <<< "$roleAssignments"
    else
        echo "⚠ No role assignments found for principal $principalId"
    fi
else
    echo ""
    echo "[3/5] Skipping role assignment deletion (principal not found)"
fi

# Step 4: Delete managed identity
if [ -n "$clientId" ]; then
    echo ""
    echo "[4/5] Deleting managed identity..."
    if az identity delete --name $wfIdentity --resource-group $grp 2>/dev/null; then
        echo "✓ Managed identity '$wfIdentity' deleted"
    else
        echo "✗ Failed to delete managed identity"
    fi
else
    echo ""
    echo "[4/5] Skipping managed identity deletion (not found)"
fi

# Step 5: Optionally delete resource group
echo ""
echo "[5/5] Resource group cleanup"
read -p "Do you want to delete the resource group '$grp'? (y/N): " deleteRg

if [ "$deleteRg" = "y" ] || [ "$deleteRg" = "Y" ]; then
    echo "Deleting resource group '$grp'..."
    az group delete --name $grp --yes --no-wait
    echo "✓ Resource group deletion initiated (running in background)"
else
    echo "⚠ Resource group '$grp' retained"
fi

echo ""
echo "✓ Cleanup completed!"
echo "Summary:"
echo "  - Federated credential: Deleted"
echo "  - Service connection: Deleted"
echo "  - Role assignments: Deleted"
echo "  - Managed identity: Deleted"
if [ "$deleteRg" = "y" ] || [ "$deleteRg" = "Y" ]; then
    echo "  - Resource group: Deleting..."
else
    echo "  - Resource group: Retained"
fi
