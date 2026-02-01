# Database DevOps

Database DevOps extends CI/CD practices to database schema and data management, ensuring version control, automated testing, and safe deployment of database changes alongside application updates. This module demonstrates two complementary approaches: **state-based** deployments using DACPAC and **change-based** deployments using Entity Framework Core migrations.

## Deployment Strategies

|                                      |                                                                                          |
| ------------------------------------ | ---------------------------------------------------------------------------------------- |
| [01-state-based](./01-state-based)   | DACPAC-based deployment declaring target database state, ideal for schema-only changes   |
| [02-change-based](./02-change-based) | Entity Framework Core migrations tracking incremental changes with rollback capabilities |

## Links & Resources

[Azure SQL database deployment](https://learn.microsoft.com/en-us/azure/devops/pipelines/targets/azure-sqldb?view=azure-devops&tabs=yaml) — Deploy and manage Azure SQL Database using Azure Pipelines

[DataOps for the modern data warehouse](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/data-warehouse/dataops-mdw) — Design data platform deployments with CI/CD practices

[Provision databases in Azure Pipelines](https://docs.microsoft.com/en-us/learn/modules/provision-database-azure-pipelines/) — Learn module for database provisioning in pipelines

[Entity Framework Core Migrations](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli) — Manage database schema changes through code-first migrations

[DBUp](https://dbup.readthedocs.io/en/latest/) — Database upgrade tool for SQL Server with transaction-based execution
