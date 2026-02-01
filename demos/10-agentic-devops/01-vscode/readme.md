# VS Code & Model Context Protocol (MCP)

## About Model Context Protocol (MCP)

[Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) is an open standard for connecting AI models to external tools and data sources. MCP servers act as bridges that enable GitHub Copilot to interact with specialized services and APIs, extending its capabilities beyond code generation. By using MCP, you can automate complex workflows, access real-time data, and integrate with platform-specific tools seamlessly within VS Code.

## Global vs. Local MCP Configuration

MCP servers can be configured at two levels:

- **Global (User)** — Registered in your user-level VS Code settings (`~/.vscode/settings.json`). Available across all workspaces and projects.
- **Local (Repository)** — Registered in [`.vscode/mcp.json`](.vscode/mcp.json) at the repository root. Specific to the project and shared with team members via version control.

The [mcp.json](.vscode/mcp.json) file in this repository defines MCPs that enhance DevOps tasks like pipeline management, cloud deployment, and infrastructure provisioning. When you open this workspace, these MCPs become available to Copilot for completing automated tasks.

## Available MCPs

| MCP                 | Purpose                                                                                                     |
| ------------------- | ----------------------------------------------------------------------------------------------------------- |
| **Microsoft Learn** | Search Microsoft documentation and retrieve official code samples for Azure services and .NET development   |
| **Azure DevOps**    | Manage pipelines, work items, service connections, and DevOps operations in Azure DevOps organizations      |
| **Azure Deploy**    | Provision and manage Azure resources, deploy applications, and orchestrate infrastructure as code workflows |
| **GitHub**          | Access repositories, pull requests, issues, and automate GitHub operations and workflows                    |
| **Playwright**      | Browser automation for testing, scraping, and visual verification of web applications and deployments       |

## MCP Registries

Discover and install additional MCPs from community registries:

- [**Smithery**](https://smithery.ai/) — Central registry for discovering and sharing MCP servers across the community
- [**MCP Servers on GitHub**](https://github.com/modelcontextprotocol/servers) — Official open-source MCP server implementations maintained by the protocol creators
- [**GitHub Copilot Extensions**](https://github.com/marketplace?type=apps) — GitHub Marketplace offers pre-built MCPs and extensions for popular development tools and platforms
