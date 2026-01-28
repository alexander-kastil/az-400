env=$1
app=$2
appPlan=foodplan-$env
loc=westeurope
grp=az400-$env

az group create -n $grp -l $loc

az appservice plan create -n $appPlan -g $grp --sku FREE 

az webapp create -n $app -g $grp --plan $appPlan --runtime "DOTNET|10.0"
