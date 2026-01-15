# Test your Agents with a variety of workloads

To use your custom agent you could use:

```yaml
pool:
    name: win-selfhosted
```

## Functional Test

Simple Agent Test `./agent-tests/test-agent.yml`:

```yaml
trigger:
    - main

pool:
    name: win-selfhosted

steps:
    - script: echo Hello, world!
      displayName: "Run a one-line script"

    - script: |
          echo Add other tasks to build, test, and deploy your project.
          echo See https://aka.ms/yaml
      displayName: "Run a multi-line script"
```

## .NET Core Test

Test a .NET 10 Build from [MVC-DevOps](https://github.com/alexander-kastil/mvc-devops) using `./agent-tests/test-agent-net.yml`

To reference you custom pool in yaml use [pool](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser#choosing-a-pool-and-agent-in-your-pipeline)

```
name: test-agent-net
trigger:
  branches:
    include:
      - master

pool:
    name: win-selfhosted
```

## Angular Test

Test an Angular Build from [Angular-DevOps](https://github.com/alexander-kastil/angular-devops) using `./deploy/agent-test.yml`

```
trigger:
  branches:
    include:
    - master

stages:
- stage: build

  jobs:
    - job: Job
      pool:
        name: win-selfhosted
```

## Microsoft 365 Stack Test

This sample is using `./agent-tests/test-agent-spfx.yml` [https://github.com/alexander-kastil/spfx-devops](https://github.com/alexander-kastil/spfx-devops/blob/main/az-pipelines/test-agent-spfx.yml)

Notice the line `RUN /installers/node.sh` in `dockerfile`. It installs **Node 22.12.0**, the **Heft-based SPFx toolchain** (Heft, Yeoman and `@microsoft/generator-sharepoint@next`), the **Angular CLI 21.1**, and the Microsoft 365 CLI. SPFx v1.22+ uses the Heft toolchain and Node 22 LTS is required — see the SPFx 1.22.1 release notes for details: https://learn.microsoft.com/en-us/sharepoint/dev/spfx/release-1.22.1. By preinstalling these tools you can remove the steps from your `*.yaml` and speed up your DevOps.

```bash
# Install Node 22.12.0 exactly
curl -fsSLO https://nodejs.org/dist/v22.12.0/node-v22.12.0-linux-x64.tar.xz
sudo tar -xJf node-v22.12.0-linux-x64.tar.xz -C /usr/local --strip-components=1

# Verify
echo "NODE Version:" && node --version
echo "NPM Version:" && npm --version

# Global tools (Heft-based toolchain)
sudo npm i -g typescript@^5.3.3 @rushstack/heft yo
sudo npm i -g @microsoft/generator-sharepoint@next
sudo npm i -g @angular/cli@21.1
sudo npm i -g @pnp/cli-microsoft365
# Microsoft 365 CLI docs: https://learn.microsoft.com/en-us/microsoft-agent-365/developer/
```
