# YAML Pipelines

## Demos

Add `simple-api-ci` to `simple-api` repo

```yml
name: "simple-api-ci-yaml"
trigger:
  branches:
    include:
      - master

pool:
  vmImage: "ubuntu-latest"

variables:
  buildConfiguration: "Release"

stages:
  - stage: "Build"
    jobs:
      - job: "Build"
        displayName: "Build Api"

        steps:
          - task: UseDotNet@2
            displayName: "Install .NET 5 SDK"
            inputs:
              packageType: "sdk"
              version: "5.x"

          - task: DotNetCoreCLI@2
            displayName: Build
            inputs:
              command: build
              projects: "**/*.csproj"
              arguments: "--configuration $(buildConfiguration)"

          - task: DotNetCoreCLI@2
            inputs:
              command: "publish"
              publishWebProjects: true
              arguments: "--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory)"

          - task: PublishBuildArtifacts@1
            inputs:
              PathtoPublish: "$(Build.ArtifactStagingDirectory)"
              ArtifactName: "drop"
              publishLocation: "Container"
```

Import the Pipeline

![add-pipeline](_images/add-pipeline.jpg)

![select-pipeline](_images/select-pipeline.jpg)
