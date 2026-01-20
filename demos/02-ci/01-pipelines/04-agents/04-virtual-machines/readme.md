# Configure a self hosted agent on an Azure Windows VM

[Self-hosted Windows agents](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops)

[Build tools für Visual Studio](https://visualstudio.microsoft.com/de/downloads)

[Agent Demands](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/demands?view=azure-devops&tabs=yaml)

## Demo

Execute `create-agent-vm.azcli` to install the vm in Cloud Shell using:

```bash
curl https://raw.githubusercontent.com/alexander-kastil/az-400/agents/demos/03-ci/01-agents/05-custom-agents/01-virtual-machines/create-agent-vm.azcli | bash
```

> Note: If you want to change the vm size use: `az vm list-sizes --location westeurope -o table`

Execute `install-sw-devops-agent-vm.ps1` from inside the vm you created in the prev step to install Build Agent on VM:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/alexander-kastil/az-400/agents/demos/03-ci/01-agents/05-custom-agents/01-virtual-machines/install-sw-devops-agent-vm.ps1'))
```

Create an agent pool `AzureVMS` in `https://dev.azure.com/<tenant>/<project>/_settings/agentqueues`

Complete the agent config:

```PowerShell
cd \agent
.\config.cmd --unattended --pool "win-selfhosted" --agent $env:COMPUTERNAME --runasservice --work '_work' --url 'https://dev.azure.com/integrationsonline/' --projectname 'az-400' --auth PAT --token lz4w2...
```

![config-agent.jpg](_images/config-agent.jpg)
