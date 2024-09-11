## Azure CLI

- Azure CLI Script
- Using Azure CLI Task in pipeline

## Readings

[Azure Cloud Shell Tools](https://docs.microsoft.com/en-us/azure/cloud-shell/features)

[Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

[Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

[Azure CLI Query](https://docs.microsoft.com/en-us/cli/azure/query-azure-cli?view=azure-cli-latest)

[JMESPath Documentation](http://jmespath.org/)

```bash
az extension list-available --output table
az extension add --name <extension-name>
```

## Extensions

[Azure Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)

[Azure CLI Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli)

## Install Azure CLI

Install Chocolatey in an elevated Prompt:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Install Azure CLI in an elevated Prompt:

```
choco install azure-cli
```

> Note: To install Azure CLI in Linux (ie. WSL) execute `install-az-cli-linux.sh`

## Getting Started

Log In:

```bash
az login
```

Try at cmd - use ctrl + d to exit:

```
az interactive
```

> Note: You can also use: `F1 - Open Bash in Cloud Shell` using Azure Account Extension

![open](_images/azure-open.png)

List available extensions:

```bash
az extension list-available --output table
az extension add --name <extension-name>
```

### Create an App Service to host a Web App:

```bash
rnd=$RANDOM
grp=az204-appservice-$rnd
appPlan=appservice-$rnd
web=foodweb-$rnd
loc=westeurope

# create a resource group
az group create -n $grp -l $loc

# create an App Service plan
az appservice plan create -n $appPlan -g $grp --sku B2
```

> Note: You could also execute `creat-app-service.azcli` or run the following remote script in Cloud Shell

```
curl https://raw.githubusercontent.com/alexander-kastil/az-400/master/setup/create-lab-vm.azcli | bash
```

### Create a Lab VM

If you want to execute the labs on a machine where you have full controll please follow this guide:

- Execute `create-lab-vm.azcli`
- Wait unitl the machine has been pvovisioned
- Connect to the VM using RDP
- Execute `Set-ExecutionPolicy bypass` in an elevated prompt using `run as administrator`
- Execute the script `setup/az-400.ps1` in an elevated prompt

> Note: To connect use the credientials from script `create-lab-vm.azcli`

```
rnd=$RANDOM
loc=westeurope
grp=az204-lab
vmname=labvm-$rnd
user=az204lab
pwd=Lab@dmin1233

az group create -n $grp -l $loc

az vm create -g $grp -n $vmname --admin-username $user --admin-password $pwd --image MicrosoftWindowsDesktop:Windows-10:20h2-entn-g2:19042.630.2011061636 --size Standard_E2s_v3
```

> Note: We are using this image and vm size because it supports nested virtualization