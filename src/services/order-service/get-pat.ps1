# Create and retrieve a PAT token for Azure Artifacts authentication
# Usage: .\get-pat.ps1 -Organization "integrationsonline" -TokenName "docker-build-token"

param(
    [Parameter(Mandatory = $false)]
    [string]$Organization = "integrationsonline",
    
    [Parameter(Mandatory = $false)]
    [string]$TokenName = "order-service-build-$(Get-Date -Format 'yyyy-MM-dd')",
    
    [Parameter(Mandatory = $false)]
    [int]$ValidDays = 90
)

# Authenticate with Azure DevOps
Write-Host "Authenticating to Azure DevOps..." -ForegroundColor Cyan
az login --allow-no-subscriptions 2>&1 | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Azure CLI authentication failed. Please run 'az login' manually." -ForegroundColor Red
    exit 1
}

# Get access token for Azure DevOps
Write-Host "Retrieving access token..." -ForegroundColor Cyan
$accessToken = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv

if ([string]::IsNullOrEmpty($accessToken)) {
    Write-Host "❌ Failed to retrieve access token" -ForegroundColor Red
    exit 1
}

# Set PAT expiration date
$validTo = (Get-Date).AddDays($ValidDays).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

# Create PAT token via Azure DevOps REST API
$apiUrl = "https://vssps.dev.azure.com/$Organization/_apis/tokens/pats?api-version=7.1-preview.1"

$body = @{
    displayName = $TokenName
    scope = "vso.packaging"
    validTo = $validTo
    allOrgs = $false
} | ConvertTo-Json

Write-Host "Creating PAT token '$TokenName' (valid for $ValidDays days)..." -ForegroundColor Cyan

$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
    
    if ($response.patToken) {
        Write-Host "✅ PAT token created successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Token Name: $($response.patToken.displayName)" -ForegroundColor Yellow
        Write-Host "Valid Until: $($response.patToken.validTo)" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "PAT Token (copy this):" -ForegroundColor Green
        Write-Host $response.patToken.token -ForegroundColor White
        Write-Host ""
        Write-Host "Use this token in your docker build command:" -ForegroundColor Cyan
        Write-Host "docker build --rm -f dockerfile -t order-service . --build-arg PAT=$($response.patToken.token)" -ForegroundColor Gray
        
        # Return the token for scripting purposes
        return $response.patToken.token
    }
    else {
        Write-Host "❌ Failed to create PAT token. Response: $($response | ConvertTo-Json)" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "❌ Error creating PAT token: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Response: $($_.ErrorDetails.Message)" -ForegroundColor Red
    exit 1
}
