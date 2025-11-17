GitHub Copilot
Read config-service

I'll continue exploring the services and other components to get a complete picture for the Mermaid diagram. Let me check the functions and web applications as well:

Read readme.md, lines 1 to 1

Read order-processor

Read payment-net

Read readme.md, lines 1 to 1

Read payment-py

Read readme.md, lines 1 to 21

Read food-shop

Read cooking-dashboard

Read readme.md, lines 1 to 1

Let me check the AI service and jobs:

Read sk-students-ai

Read blob-java

Read blob-spring

Now let me examine some key source files to understand the technology stack and dependencies:

Read Program.cs, lines 1 to 31

Read app.config.ts, lines 1 to 1

Read package.json, lines 1 to 31

Now I have enough information to create a comprehensive Mermaid diagram showing all the services and their relationships in the Food App architecture. Let me create the diagram:

Created services-architecture.md

I've created a comprehensive Mermaid diagram that shows all the services in the src directory of your Food App project. The diagram includes:

Services Overview:
Web Applications (Angular)
Food Shop (customer-facing)
Cooking Dashboard (staff interface)
Core Services (.NET)
Catalog Service (food catalog management)
Order Service (order processing with CQRS)
Prime Service (additional business logic)
Config Service (configuration management)
Azure Functions
Order Processor (.NET)
Payment processors (.NET and Python)
Utils (TypeScript)
AI Services
SK Students AI (using Semantic Kernel)
Background Jobs
Blob processing (Java and Spring Boot)
Shared Components
Food App Common library
The diagram shows the relationships between services, their connections to Azure services (Key Vault, Storage, Application Insights, etc.), and uses different colors to categorize the different types of services. Each service includes relevant technical details like ports for the core services and technology stacks used.

The architecture follows a microservices pattern with clear separation of concerns, modern cloud-native practices, and includes monitoring and async processing capabilities.
