# Configure a Self-hosted Agent on an Azure Windows VM

Self-hosted agents on Windows VMs provide full OS control and flexibility to install custom build tools. This demo shows how to provision a Windows VM, install the Azure Pipelines agent, and configure it to handle complex build scenarios requiring specific software dependencies.

## Demos

### Provision Azure Windows VM for DevOps Agent

Demonstrates infrastructure setup using Azure CLI. The [create-agent-vm.azcli](create-agent-vm.azcli) script provisions a Gen2 Windows Server 2025 VM with nested virtualization support, using cost-effective Dv3-series sizing (D2s_v3). Key features:

- **Windows Server 2025**: Latest OS with modern tooling support
- **Nested virtualization**: Enables container and Hyper-V workloads on the agent
- **Cost-optimized**: D2s_v3 provides 2 vCPUs and sufficient compute for most build tasks
- **Customizable sizing**: Use `az vm list-sizes --location westeurope -o table` to adjust VM tier as needed

Customize the script variables for your requirements (location, resource group naming, VM size).

### Install Build Tools and Azure Pipelines Agent

Installs a comprehensive development toolchain on the Windows VM using the [install-sw-devops-agent-vm.ps1](install-sw-devops-agent-vm.ps1) PowerShell script. The automation installs:

- **Development tools**: Git, Visual Studio 2022 Build Tools, Visual Studio Code, Azure CLI
- **Runtime dependencies**: .NET SDK 10, Node.js 22.12.0, npm packages
- **Azure Pipelines agent**: Downloads latest agent release from GitHub and extracts to `C:\agents`

The script outputs configuration instructions to complete agent registration with your Azure DevOps organization.

### Configure Agent for DevOps Service

Complete the agent setup by running the configuration command from the extracted agent directory. Key configuration points:

```powershell
cd C:\agents
.\config.cmd --unattended --pool "win-selfhosted" --agent $env:COMPUTERNAME --runasservice --work '_work' --url 'https://dev.azure.com/<org>/' --projectname '<project>' --auth PAT --token '<pat-token>'
```

Configuration parameters:

- `--pool`: Agent pool name (created in Azure DevOps Project Settings → Agent Pools)
- `--runasservice`: Runs agent as Windows service for persistent availability
- `--auth PAT`: Uses Personal Access Token for authentication (more secure than passwords)

![config-agent.jpg](_images/config-agent.jpg)
_Agent configuration output showing successful registration_

Once configured, the agent appears in your agent pool and can execute pipeline jobs.

## Links & Resources

[Self-hosted Windows agents](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops)

[Build tools for Visual Studio](https://visualstudio.microsoft.com/downloads)

[Agent Demands](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/demands?view=azure-devops&tabs=yaml)
