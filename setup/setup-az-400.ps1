# Install Software
winget install Google.Chrome
winget install Microsoft.VisualStudioCode
winget install Git.Git
winget install GitExtensionsTeam.GitExtensions
winget install GitHub.GitLFS
winget install GitTools.GitVersion
winget install Microsoft.DotNet.SDK.8
winget install OpenJS.NodeJS.LTS --version 20.12.2
winget install Microsoft.AzureCLI
winget install Microsoft.AzureFunctionsCoreTools --params "/x64:true"
winget install GitHub.cli
winget install curl.curl
winget install microsoft.azd

# Refresh Path Env for npm 
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Set NuGet Source
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

# Install VS Code Extensions
winget install ms-dotnettools.csharp
winget install ms-vscode.powershell
winget install ms-vscode.azurecli
winget install ms-vscode.azure-account
winget install ms-azuretools.vscode-azureappservice
winget install ms-azuretools.vscode-docker
winget install ms-azuretools.vscode-azurefunctions
winget install GitHub.vscode-pull-request-github
winget install redhat.vscode-yaml
winget install bencoleman.armview
winget install mdickin.markdown-shortcuts
winget install mhutchie.git-graph
winget install ms-azure-devops.azure-pipelines
winget install ms-azuretools.vscode-azureterraform
winget install vs-publisher-1448185.keyoti-changeallendoflinesequence
winget install ms-kubernetes-tools.vscode-kubernetes-tools
winget install msazurermtools.azurerm-vscode-tools
winget install ms-azuretools.vscode-bicep
winget install ms-azuretools.vscode-azurecontainerapps

# Azurite Storage Emulator
npm install -g azurite

# Install Angular
npm i -g @angular/cli

# Http-Server
npm i -g http-server

# Finished Msg
Write-Host "Finished Software installation" -ForegroundColor yellow
