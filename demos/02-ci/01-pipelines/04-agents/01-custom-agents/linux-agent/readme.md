# Implement & Use a Self-hosted Docker Linux Agent

A production ready version of this agent is published at [DockerHub](https://hub.docker.com/repository/docker/alexander-kastil/aciagentlinux)

## Configure Agent Container

### Examine the dockerfile

The dockerfile basically executes these steps:

- Install tooling (wget, curl, ...)
- Download `vstsagentpackage-xxx` with the default software. 
- Execute default software installation from extracted `vstsagentpackage-xxx` using `start.sh` which executes `run.sh`
- Add custom software using optional installer scripts

The dockerfile contains the `AGENT_VERSION` which is `2.185.1` in this case. You can get the current version from the [azure-pipelines-agent](https://github.com/Microsoft/azure-pipelines-agent/releases) repo. 

```bash
ARG TARGETARCH=amd64
ARG AGENT_VERSION=2.185.1
```

This information is used to decide thich package of the agent to download and install:

```
AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz;
```

To add capabilities you have to add setup scripts to `/installers/` and update the `Dockerfile` to install the required software

```docker
COPY installers /installers

RUN /installers/netcore.sh
```

Build & Upload Linux Agent:

```bash
docker build -t devopsagentlinux .
docker tag devopsagentlinux alexander-kastil/devopsagentlinux
docker push alexander-kastil/devopsagentlinux
```

>Note: Local testing can be done using: `docker run -it --rm aciagentlinux -e AZP_URL=$org -e AZP_TOKEN=$token -e AZP_POOL=$pool`

## Host Agent on Azure Container Instances

Create a custom agent pool - ie: `selfhosted`

![aci-pool](../_images/aci-pool.png)

Get Azure DevOps token:

![devops-token](../_images/devops-token.png)

Export token to env or add it to script:

```
export token=ae3ypool6mvpf7624it7j4smbveyrics4rnpu...
```

Execute `creat-linux-agent.azcli` to upload agent and create Container Instance. Update Environment Vars:

```bash
az container create -g $grp -l $loc -n $agent --image $img --cpu 1 --memory 1 --dns-name-label $agent --port 80 --environment-variables 'AZP_URL'=$org 'AZP_TOKEN'=$token 'AZP_AGENT_NAME'=$agent 'AZP_POOL'=$pool
```

Check if agent was registered in your DevOps orga:

![agent-up](../_images/agent-up.png)