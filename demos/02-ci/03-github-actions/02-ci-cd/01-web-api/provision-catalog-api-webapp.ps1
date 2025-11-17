# PowerShell script to provision Azure Web App for catalog API

$env = "github-actions"
$grp = "az400-m02-$env"
$loc = "westeurope"
$appPlan = "foodplan-$env"
$app = "catalog-api-$env"

az group create -n $grp -l $loc
az appservice plan create -n $appPlan -g $grp --sku FREE
az webapp create -n $app -g $grp --plan $appPlan --runtime "dotnet:8"