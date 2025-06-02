# Development Container for Fitness App

This devcontainer configuration provides a complete development environment for the Fitness application that consists of:

- Angular 19 frontend (fitness-ui)
- .NET 9 Web API backend with Entity Framework Core and SQLite (fitness-api)

## Prerequisites

- Docker Desktop
- Visual Studio Code with Remote - Containers extension

## Features

- Node.js 20.12.2 for Angular 19 development
- .NET 9 SDK for backend development
- SQLite for database
- VS Code extensions for both Angular and .NET development

## Getting Started

1. Open this folder in VS Code
2. When prompted, click "Reopen in Container"
3. Wait for the container to build (this may take a few minutes the first time)
4. Start developing!

## Available Commands

### Angular UI (within the src/fitenss-ui directory)

```bash
# Start the Angular development server
ng serve

# Generate new components, services, etc.
ng generate component my-component
```

### .NET API (within the src/fitness-api directory)

```
# Run the API
dotnet run

# Build the project
dotnet build
```

## Note

The Angular environments are already configured with apiUrl pointing to http://localhost:5000/, which is the default URL for the .NET API when running in development mode.
