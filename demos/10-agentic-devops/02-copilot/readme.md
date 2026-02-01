# Copilot Agent & Skills

## Copilot Artifacts

GitHub Copilot integrates with this repository through reusable instructions, prompts, and skills defined in [`.github/`](/.github/). These artifacts guide Copilot's behavior from basic code generation to advanced DevOps automation.

| Artifact                                                     | Description                                                                                                                                                                                  |
| ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[Copilot Instructions](/.github/copilot-instructions.md)** | Core guidelines for the training repository. Covers repository structure, coding standards, pipeline conventions, and workload identity federation patterns for secure Azure authentication. |
| **[Language / Stack Instructions](/.github/instructions/)**  | Domain-specific coding standards for Angular, .NET, Azure CLI, and documentation. Ensures consistent code quality and practices across different technology stacks.                          |
| **[Reusable Prompts](/.github/prompts/)**                    | Pre-built prompt templates for common tasks: documentation generation, demo descriptions, playwright testing, and pipeline imports. Accelerates repetitive work with consistent guidance.    |
| **[Copilot Skills](/.github/skills/)**                       | Documented automation patterns for Azure DevOps: creating workload identity federations, retrieving pipeline logs, and importing pipelines. Self-documenting and regularly validated.        |
| **[Copilot Agents](/.github/agents/)**                       | Specialized AI agents for Angular development, Azure DevOps, Azure deployment, GitHub Actions, and smoke testing. Each agent uses specific MCPs and tools for targeted expertise.            |
