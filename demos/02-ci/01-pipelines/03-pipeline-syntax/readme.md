# Pipelines & YAML: basics, expressions & conditions, variables, triggers

## Elements of Azure DevOps Pipelines:

Azure DevOps Pipelines organize work into logical containers: stages group related jobs, jobs represent units of work that run on agents, and steps are individual tasks within jobs. This hierarchical structure enables complex CI/CD workflows with conditional execution, parallel processing, and cross-stage data sharing.

![key-concepts-overview](_images/key-concepts-overview.svg)

## Demos

### 02-03-pipeline-basics.yml - Basic Pipeline Syntax

Demonstrates the fundamental structure of an Azure Pipeline including stages, jobs, and steps. Shows how to organize parallel and sequential job execution using `dependsOn` constraints, configure multiple agent pools, and enable pipeline debugging. Key feature: inline vs. referenced pool configurations for flexible agent selection.

### 02-03-pipeline-triggers.yml - Pipeline Triggers

Configures when pipelines execute using branch and path-based triggers. Demonstrates include/exclude patterns for both branches and file paths to control CI activation. Notable: trigger filtering reduces unnecessary pipeline runs for unrelated code changes.

### 02-03-conditions-expressions.yml - Conditions & Expressions

Illustrates dynamic pipeline behavior using runtime and compile-time expressions. Covers variable group imports, expression syntax variants (template expressions vs. macro syntax), and conditional step execution. Notable detail: demonstrates the difference between `${{ }}` (template) and `$()` (macro) evaluation timing, critical for conditional logic.

### 02-03-variables-scopes.yml - Variables & Scopes

Shows how to pass data between jobs and stages using variable scoping rules. Includes job-to-job variable passing with `dependencies` and stage-to-stage output with `stageDependencies`. Key feature: `isOutput=true` flag enables cross-stage data propagation, essential for multi-stage orchestration patterns.

### 02-03-parallel-jobs.yml - Parallel Jobs

Demonstrates concurrent job execution within a stage for parallel build and test workflows.

## Links & Resources

[Key concepts for new Azure Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/get-started/key-pipelines-concepts?view=azure-devops)

[Azure Pipeline YAML Schema Reference](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema%2Cparameter-schema)

[Predefined Variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml)

[Using Variables in Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch)

[Understand variable syntax](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch#understand-variable-syntax)

[Azure DevOps Expressions](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/expressions?view=azure-devops)

[Specify events that trigger pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/triggers?view=azure-devops)
