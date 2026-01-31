# State-Based Database Deployment

State-based deployment (also called **schema comparison**) declares the target state of the database schema and applies the minimum changes needed to reach that state. The most common tool for SQL Server is **DACPAC** (Data-tier Application Package).

## Key Concepts

- **Target State**: Define desired schema in SQL Server Data Tools (SSDT) or DACPAC projects
- **Comparison**: Tools compare current database against target state
- **Minimal Changes**: Only generates necessary T-SQL scripts, reducing migration risk
- **Idempotent**: Safe to re-run deployment with same result
- **No History Tracking**: No migration history needed; state declarations are self-documenting

## Best For

✅ Schema-only changes with no complex data migrations  
✅ When you need automatic conflict resolution  
✅ Large teams where coordination is critical  
✅ Database refactoring and cleanup operations

## DACPAC Deployment

Deploy SQL Server DACPAC files using Azure DevOps:

```bash
# Extract DACPAC and deploy to target database
SqlPackage.exe /Action:Publish /SourceFile:database.dacpac \
  /TargetConnectionString:"Server=tcp:myserver.database.windows.net;Database=mydb;..." \
  /p:BlockOnPossibleDataLoss=false
```

## Links & Resources

[SQL Server Data Tools (SSDT)](https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt) — Create and manage DACPAC projects

[DACPAC Overview](https://learn.microsoft.com/en-us/sql/relational-databases/data-tier-applications/data-tier-applications) — Understand data-tier application packages

[SqlPackage Command-Line Tool](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage) — Deploy DACPAC files from command line or pipelines
