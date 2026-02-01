# Agentic DevOps with GitHub Copilot

Agentic DevOps leverages AI-powered agents to automate complex DevOps workflows, accelerating development cycles while reducing manual effort and human error. This module demonstrates how GitHub Copilot, combined with Model Context Protocol (MCP) servers and specialized agents, transforms DevOps from manual operations into intelligent automation.

## Benefits of Agentic DevOps with GitHub Copilot

**Intelligent Automation** — Copilot automates repetitive DevOps tasks like pipeline creation, infrastructure provisioning, and deployment workflows. Instead of writing boilerplate YAML or scripts, you describe what you want and Copilot generates production-ready code following best practices from Microsoft Learn, reducing creation time from hours to minutes.

**Knowledge Integration** — Copilot integrates official Microsoft documentation through the Microsoft Learn MCP, eliminating context-switching between code and browser. It surfaces relevant documentation and code samples in real-time, ensuring your solutions align with current platform recommendations.

**Proactive Problem Solving** — Rather than waiting for pipelines to fail, Copilot analyzes your infrastructure code, pipelines, and configurations upfront to identify issues, predict misconfigurations, and catch permission problems before they reach production.

## Getting Started

Explore Agentic DevOps through these demonstrations:

1. **[VS Code & MCP](01-vscode/)** — Learn about Model Context Protocol and MCPs available in this workspace
2. **[Copilot Artifacts](02-copilot/)** — Understand instructions, prompts, skills, and agents that guide Copilot's behavior

For hands-on experience, use natural language prompts like:

- "Create a pipeline that builds and deploys the catalog service"
- "Set up workload identity federation for secure Azure authentication"
- "Import the terraform-ci-cd pipeline and run it"
- "What went wrong with the last deployment?"

Copilot will engage appropriate agents, coordinate MCPs, and guide you through complex DevOps tasks with expert guidance and validated automation.
