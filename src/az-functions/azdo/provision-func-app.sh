env=$1
grp=az400-funcapp-$env
loc=westeurope
app=func-devops-$env
storage=funcdevops$env

az group create -n $grp -l $loc

az storage account  create -n $storage -g $grp --sku Standard_LRS

az functionapp create -n $app -g $grp --storage-account $storage --consumption-plan-location $loc --runtime node --runtime-version 14 --functions-version 4