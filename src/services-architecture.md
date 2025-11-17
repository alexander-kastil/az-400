# Food App Services Architecture

```mermaid
graph TB
    %% Web Applications
    subgraph "Web Applications"
        FS[Food Shop<br/>Angular 18]
        CD[Cooking Dashboard<br/>Angular]
    end

    %% Core Services
    subgraph "Core Services (.NET)"
        CS[Catalog Service<br/>Port: 5001/5021<br/>Dapr: 5011]
        OS[Order Service<br/>Port: 5002/5022<br/>Dapr: 5012]
        PS[Prime Service<br/>.NET Core]
        CNS[Config Service<br/>.NET Core]
    end

    %% Functions
    subgraph "Azure Functions"
        OP[Order Processor<br/>.NET Function]
        PN[Payment .NET<br/>.NET Function]
        PP[Payment Python<br/>Python Function]
        UT[Utils TypeScript<br/>TypeScript Function]
    end

    %% AI Services
    subgraph "AI Services"
        AI[SK Students AI<br/>.NET with Semantic Kernel]
    end

    %% Background Jobs
    subgraph "Background Jobs"
        BJ[Blob Java<br/>Java Job]
        BS[Blob Spring<br/>Spring Boot Job]
    end

    %% Shared Libraries
    subgraph "Shared Components"
        FAC[Food App Common<br/>Shared Library]
    end

    %% External Dependencies
    subgraph "Azure Services"
        DB[(SQL Server/<br/>SQLite Database)]
        KV[Azure Key Vault]
        AI_SERVICE[Azure OpenAI/<br/>Cognitive Services]
        STORAGE[Azure Storage]
        INSIGHTS[Application Insights]
        SERVICEBUS[Service Bus]
    end

    %% Web to Services connections
    FS --> CS
    FS --> OS
    CD --> OS
    CD --> CS

    %% Service dependencies
    CS --> DB
    OS --> DB
    CS --> KV
    OS --> KV
    PS --> KV
    CNS --> KV

    %% Functions connections
    OS --> OP
    OP --> PN
    OP --> PP
    PN --> STORAGE
    PP --> STORAGE

    %% AI connections
    AI --> AI_SERVICE
    AI --> DB

    %% Background jobs
    BJ --> STORAGE
    BS --> STORAGE

    %% Shared library usage
    CS -.-> FAC
    OS -.-> FAC
    PS -.-> FAC

    %% Monitoring
    CS --> INSIGHTS
    OS --> INSIGHTS
    PS --> INSIGHTS
    FS --> INSIGHTS
    CD --> INSIGHTS
    PN --> INSIGHTS
    PP --> INSIGHTS
    AI --> INSIGHTS

    %% Service Bus for async communication
    OS --> SERVICEBUS
    OP --> SERVICEBUS

    %% Styling
    classDef webApp fill:#e1f5fe
    classDef service fill:#f3e5f5
    classDef function fill:#fff3e0
    classDef ai fill:#e8f5e8
    classDef job fill:#fce4ec
    classDef azure fill:#fff9c4
    classDef shared fill:#f1f8e9

    class FS,CD webApp
    class CS,OS,PS,CNS service
    class OP,PN,PP,UT function
    class AI ai
    class BJ,BS job
    class DB,KV,AI_SERVICE,STORAGE,INSIGHTS,SERVICEBUS azure
    class FAC shared
```

## Service Details

### Web Applications

- **Food Shop**: Angular 18 customer-facing application for ordering food
- **Cooking Dashboard**: Angular dashboard for restaurant staff to manage orders

### Core Services (.NET)

- **Catalog Service**: Manages food catalog, menus, and product information
- **Order Service**: Handles order processing, CQRS pattern implementation
- **Prime Service**: Additional business logic service
- **Config Service**: Configuration management service

### Azure Functions

- **Order Processor**: .NET function for processing orders asynchronously
- **Payment .NET**: .NET-based payment processing function
- **Payment Python**: Python-based payment processing function
- **Utils TypeScript**: Utility functions written in TypeScript

### AI Services

- **SK Students AI**: .NET application using Semantic Kernel for AI capabilities

### Background Jobs

- **Blob Java**: Java-based job for blob storage operations
- **Blob Spring**: Spring Boot job for storage management

### Shared Components

- **Food App Common**: Shared library containing common models and utilities

### Technology Stack

- **Frontend**: Angular 18 with Material Design
- **Backend**: .NET Core, ASP.NET Core
- **Functions**: Azure Functions (.NET, Python, TypeScript)
- **AI**: Semantic Kernel, Azure OpenAI
- **Jobs**: Java, Spring Boot
- **Database**: SQL Server / SQLite
- **Authentication**: Azure AD, MSAL
- **Monitoring**: Application Insights
- **Infrastructure**: Docker, Azure Container Apps, Dapr
