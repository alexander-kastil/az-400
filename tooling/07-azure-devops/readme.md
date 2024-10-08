# Register Azure DevOps Organization

Go to [https://azure.microsoft.com/de-de/products/devops](https://azure.microsoft.com/de-de/products/devops) to register your Azure DevOps Organization

![register-1](_images/register-1.png)

Create your DevOps organization. This will also the name of your first project:

![register-orga](_images/register-orga.png)

Due to a resource shortage explained [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/licensing/concurrent-jobs?view=azure-devops&tabs=ms-hosted) you have to request free build minutes for Microsoft hosted agents

![shortage](_images/shortage.png)

Fill out the [request](https://aka.ms/azpipelines-parallelism-request) to get the grant for free agent build minutes:

![free-grants](_images/free-grants.png)

You can check the grant at: `https://dev.azure.com/<DEVOPS-ORGA>/_settings/buildqueue?_a=concurrentJobs`

![free-jobs](_images/free-jobs.png)

>Note: As an alternative you can use your own Azure Hosted Agents which will be covered in Module 04