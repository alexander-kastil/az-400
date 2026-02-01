# Implementing Custom DevOps Agents

## Custom Agent Options

| Agent Type                                                        | Pros                                                                                                                                          | Cons                                                                                                                                                |
| ----------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[Self-hosted Docker (Container Instances)](01-custom-agents/)** | Lightweight, portable, quick to scale up/down; containerized workloads; built-in image versioning; cost-effective for bursty workloads.       | Requires Docker knowledge; network latency for container registry pulls; limited to container-based tasks.                                          |
| **[Virtual Machines (Windows/Linux)](04-virtual-machines/)**      | Full OS control, install any software; persistent state; good for complex build toolchains; supports agent demands and capabilities.          | Higher operational overhead; manual patching/updates; long startup times; persistent costs even when idle.                                          |
| **[Azure Managed DevOps Pools](03-az-managed-pools/)**            | Azure-managed, zero operational overhead; automatic scaling and maintenance; integrated with Azure portal; no agent installation required.    | Limited customization; newer service with fewer features; potential cost implications for large teams; less control over underlying infrastructure. |
| **[Azure Container Apps Jobs](05-container-apps/)**               | Serverless scaling; event-driven execution; automatic cleanup; integrates with Azure Container Registry; lower latency in Azure environments. | Limited to containerized agents; less mature than VMs; container networking complexity; requires ACR setup.                                         |

## Demo Folders

- [01-custom-agents/](01-custom-agents/) - Self-hosted Docker agents on Azure Container Instances
- [03-az-managed-pools/](03-az-managed-pools/) - Azure Managed DevOps Pools (zero-ops agent management)
- [04-virtual-machines/](04-virtual-machines/) - Self-hosted agents on Azure Windows VMs
- [05-container-apps/](05-container-apps/) - Self-hosted agents using Azure Container Apps

## Links & Resources

[Azure Pipelines agents](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser)

[Microsoft hosted Agents Software Inventory](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml)

[Azure virtual machine scale set agents](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents)

[Managed DevOps Pools](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/overview?view=azure-devops)
