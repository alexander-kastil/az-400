# Azure DevOps Pipeline Import Skill

A GitHub Copilot skill for automating Azure DevOps pipeline imports, execution, and error resolution.

## Quick Start

Ask GitHub Copilot:

```
@workspace I want to import and run the pipeline from .azdo/spfx-ci-cd.yml using the metadata in deploy.json
```

## What This Skill Does

1. **Imports pipelines** from YAML files to Azure DevOps
2. **Executes pipelines** and monitors their status
3. **Diagnoses errors** by analyzing logs and documentation
4. **Fixes issues** by updating YAML files with correct syntax

## Example Usage

```bash
# Import a pipeline
az pipelines create \
  --name "03-02-spfx-ci-cd" \
  --yml-path ".azdo/spfx-ci-cd.yml" \
  --repository "https://github.com/your-repo" \
  --service-connection "<CONNECTION_ID>" \
  --org "<ORG_URL>" \
  --project "<PROJECT>"

# Run the imported pipeline
az pipelines run --id <PIPELINE_ID> --org "<ORG_URL>" --project "<PROJECT>"

# Check status
az pipelines runs show --id <RUN_ID> --org "<ORG_URL>" --project "<PROJECT>"
```

## Deployment Metadata

Create a `deploy.json` file in the `.azdo` directory:

```json
{
    "Service Connection": "wi-az400-dev",
    "Git Repo Url": "https://github.com/alexander-kastil/az-400",
    "GitHub Service Connection ID": "231c44ad-d4a9-4055-bca6-40bab720370f",
    "ADOOrg": "https://dev.azure.com/integrationsonline",
    "ADOProject": "az-400"
}
```

## Key Features

- **Metadata-driven**: Configuration stored in deploy.json
- **Error diagnosis**: Automatic error detection and research
- **Documentation integration**: Uses Microsoft Learn MCP for official docs
- **Complete workflow**: Import → Run → Fix → Verify

## Prerequisites

- Azure CLI with `azure-devops` extension
- Azure DevOps organization access
- GitHub service connection configured
- Pipeline YAML files in repository

## Documentation

See [SKILL.md](SKILL.md) for complete documentation.
