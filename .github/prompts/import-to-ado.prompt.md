---
name: Import to ADO
description: This prompt is used to import pipelines into Azure DevOps.
agent: AzDevOps
---

Import the attached or requested by name pipelines into Azure DevOps.

Before importing, ensure that:

- The pipeline YAML files are correctly placed in the repository.
- The yaml is up to date and according to best practices which you check against the Microsoft Learn MCP
- Import the pipelines. If it is there, overwrite the existing pipeline with the same name.
- Most pipelines require at least 20 seconds to run.
- After importing, run the pipeline and check the log files for errors or warnings.
- Finally present a summary of the imported pipelines, changes applied, and a link to the last pipeline run.
