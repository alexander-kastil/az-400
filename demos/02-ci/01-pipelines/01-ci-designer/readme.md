# .NET Core CI with Designer Pipeline

Demonstrates creating and configuring a Continuous Integration (CI) pipeline using Azure DevOps Classic Designer interface. This approach provides a visual, drag-and-drop alternative to YAML pipelines for building and publishing .NET Core applications.

> Note: Classic designer pipelines are disabled by default. Enable them in Project Settings > Pipelines > Settings.

## Demos

**Classic Designer Pipeline** - Build a .NET Core application using the Azure DevOps visual pipeline designer. The pipeline defined in [02-02-net-api-ci-designer.json](./02-02-net-api-ci-designer.json) includes restore, build, and publish tasks configured through the UI rather than code. This demo shows how the designer generates equivalent task configurations for .NET CLI operations.

**Simple Release Verification** - Confirms that the build artifacts can be deployed, demonstrating the complete CI/CD workflow from code build through artifact publication.

## Links & Resources

[Build Tasks](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/?view=azure-devops)
