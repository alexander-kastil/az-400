# Azure Container Apps Agents

Azure Container Apps Jobs provide serverless execution for self-hosted DevOps agents with automatic scaling based on workload demand. This demo shows how to deploy containerized agents on Container Apps Jobs, eliminating the need to manage infrastructure while maintaining full agent capabilities.

## Demos

### Deploy Self-hosted CI/CD Agents with Azure Container Apps Jobs

Demonstrates deploying DevOps agents as containerized jobs on Azure Container Apps with event-driven scaling. The approach leverages Container Apps Jobs for ephemeral agent execution that automatically scales to zero when idle. Key features:

- **Serverless scaling**: Agents scale up to handle pipeline demand and scale to zero when idle, optimizing costs for variable workloads
- **Event-driven execution**: Agents spin up only when jobs are queued, reducing unnecessary compute consumption
- **Azure Container Registry integration**: Agents pull containerized workloads directly from ACR with native authentication
- **Automatic cleanup**: Container Apps Jobs automatically clean up completed agent instances, reducing operational overhead

This approach is ideal for teams with variable build patterns who want the flexibility of containerization without managing container orchestration infrastructure.

## Links & Resources

[Tutorial: Deploy self-hosted CI/CD runners and agents with Azure Container Apps jobs](https://learn.microsoft.com/en-us/azure/container-apps/tutorial-ci-cd-runners-jobs?tabs=bash&pivots=container-apps-jobs-self-hosted-ci-cd-azure-pipelines)
