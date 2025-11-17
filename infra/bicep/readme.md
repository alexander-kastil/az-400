#  Provision a Azure Container Application Environment

```bash
env=dev
loc=westeurope
grp=az400-$env
acr=az400acr$env
acaenv=az400-acaenv

az group create -n $grp -l $loc

az deployment group create -f aca-env.bicep \
    -g $grp \    
    -p acaEnvName=$acaenv \
    -p acrName=$acr \
```