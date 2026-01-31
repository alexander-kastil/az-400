# Implementing Continuous Integration using Azure DevOps pipelines

## Demos

| Pipeline                                                | Description                                                                                                     |
| ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| [angular-ci.yml](/.azdo/angular-ci.yml)                 | Builds and tests Angular app. Installs Node.js, runs npm install and build, and compiles TypeScript.            |
| [react-ci.yml](/.azdo/react-ci.yml)                     | Builds and tests React app. Uses Node.js with npm for dependency installation and build.                        |
| [spring-ci.yml](/.azdo/spring-ci.yml)                   | Builds Java Spring Boot application. Installs Java 17 and uses Maven with caching for faster builds.            |
| [payment-func-py-ci.yml](/.azdo/payment-func-py-ci.yml) | Builds Python Azure Function for payment processing. Installs Python 3.12 and prepares function for deployment. |
| [python-mcp-ci.yml](/.azdo/python-transcriber-mcp.yml)  | Builds and tests Python MCP Server for YouTube transcription. Installs Python 3.11 and runs tests.              |
| [spfx-ci.yml](/.azdo/spfx-ci.yml)                       | SharePoint Framework CI pipeline with build, test, and validation steps                                         |

## Links & Resources

[YAML schema reference](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema)

[Stages in Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

[Task types & usage](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/tasks?view=azure-devops&tabs=yaml)

[Build and release tasks](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/?view=azure-devops)

[Use predefined variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml)

[Configure run or build numbers](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml)

[Build and release retention policies](https://learn.microsoft.com/en-us/azure/devops/pipelines/policies/retention?view=azure-devops&tabs=yaml)

[Using resources in pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/about-resources?view=azure-devops&tabs=yaml#use-resources-to-enhance-security)

## Additional Labs & Walkthroughs

[Create a build pipeline with Azure Pipelines](https://learn.microsoft.com/en-us/training/modules/create-a-build-pipeline/?ns-enrollment-type=learningpath&ns-enrollment-id=learn.az-400-define-implement-continuous-integration)
