# Implement & Use a Self-hosted Docker Windows Agent

Enable Windows Container Feature:

```Powershell
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All
```

Build Windows Agent:

```powershell
$agent="devopsagentwindows"
$dockerhubuser="alexander-kastil"
docker build -t $agent .
docker tag $agent $dockerhubuser/$agent
docker push $dockerhubuser/$agent
```

## Host Agent on Azure Container Instances

Create a custom agent pool - ie: `selfhosted`

![aci-pool](../_images/aci-pool.png)

Get Azure DevOps token:

![devops-token](../_images/devops-token.png)

Export token to env or add it to script:

```
export token=ae3ypool6mvpf7624it7j4smbveyrics4rnpu...
```

Execute `create-win-agent.azcli` to upload agent and create Container Instance. Update Environment Vars:

```bash
az container create -g $grp -l $loc -n $agent --image $img --cpu 1 --memory 1 --dns-name-label $agent --port 80 --environment-variables 'AZP_URL'=$org 'AZP_TOKEN'=$token 'AZP_AGENT_NAME'=$agent 'AZP_POOL'=$pool
```

Check if agent was registered in your DevOps orga:

![agent-up](../_images/agent-up.png)