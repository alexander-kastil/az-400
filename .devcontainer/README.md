# Development Container for Fitness App

This devcontainer configuration provides a complete development environment for the Fitness application that consists of:

- Angular 19 frontend (fitness-ui)
- .NET 9 Web API backend with Entity Framework Core and SQLite (fitness-api)
- Azure Functions development with Python 3.11
- Complete Azure development toolkit

## Prerequisites

- Docker Desktop
- Visual Studio Code with Remote - Containers extension

## Features

- **Frontend Development**:
  - Node.js 20.12.2 for Angular 19 development
  - Angular CLI 19 for project scaffolding and development
- **Backend Development**:
  - .NET 9 SDK for API development with Entity Framework Core
  - SQLite for local database development
- **Azure Development**:
  - Python 3.11 for Azure Functions development
  - Azure CLI for Azure resource management
  - Azure Developer CLI (azd) for complete Azure development workflows
  - Azure Functions Core Tools v4 for local function development and testing
- **Development Tools**:
  - VS Code extensions for Angular, .NET, Python, and Azure development
  - Pre-configured formatters and linting tools
  - GitHub Copilot integration with Azure-specific coding instructions

## Getting Started

1. Open this folder in VS Code
2. When prompted, click "Reopen in Container"
3. Wait for the container to build (this may take a few minutes the first time)
4. Start developing!

## Available Commands

### Angular UI (within the src/fitness-ui directory)

```bash
# Start the Angular development server
ng serve

# Generate new components, services, etc.
ng generate component my-component
```

### .NET API (within the src/fitness-api directory)

```bash
# Run the API
dotnet run

# Build the project
dotnet build
```

### Azure Functions (Python)

```bash
# Create a new function app
func init MyFunctionApp --worker-runtime python

# Create a new function
func new --language python --template "HTTP trigger" --name HttpExample

# Start the Azure Functions runtime locally
func start

# Deploy to Azure (after configuring with azd or az cli)
func azure functionapp publish <function-app-name>
```

### Azure CLI Commands

```bash
# Login to Azure
az login

# List subscriptions
az account list

# Set active subscription
az account set --subscription "subscription-name"

# Create resource group
az group create --name myResourceGroup --location eastus
```

### Azure Developer CLI (azd) Commands

```bash
# Initialize a new project
azd init

# Deploy to Azure
azd up

# Monitor deployments
azd monitor
```

## Port Forwarding

The container automatically forwards these ports:

- **4200**: Angular development server
- **5000**: .NET API (HTTP)
- **5001**: .NET API (HTTPS)
- **7071**: Azure Functions runtime

## Note

The Angular environments are already configured with apiUrl pointing to http://localhost:5000/, which is the default URL for the .NET API when running in development mode.

## Azure Development

This container includes all necessary tools for Azure development:

- Use `az` commands for Azure resource management
- Use `azd` commands for end-to-end Azure development workflows
- Use `func` commands for Azure Functions development and local testing
- Python 3.11 is pre-installed for Azure Functions Python development

## Quick Start for Azure Functions

1. Create a new Python Azure Function:

   ```bash
   func init MyPythonFunctions --worker-runtime python
   cd MyPythonFunctions
   func new --language python --template "HTTP trigger" --name HttpTrigger
   ```

2. Start the function locally:

   ```bash
   func start
   ```

3. Test your function at http://localhost:7071/api/HttpTrigger
