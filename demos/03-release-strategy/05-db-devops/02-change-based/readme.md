# Change-Based Database Deployment

Change-based deployment tracks **incremental schema changes** as versioned migrations, maintaining a complete history of database evolution. Entity Framework Core migrations is the most common approach for .NET applications.

## Key Concepts

- **Migration History**: Each change is a versioned migration tracked in version control
- **Incremental Changes**: Apply only new migrations that haven't been run
- **Rollback Support**: Migrations include down methods to reverse changes
- **Code-First**: Define schema in C# classes; migrations auto-generate from changes
- **Audit Trail**: Complete history shows who changed what and when

## Best For

✅ Complex data migrations during schema changes  
✅ When rollback capability is critical  
✅ Multi-environment deployments requiring audit trails  
✅ Applications using object-relational mapping (ORM)

## Entity Framework Core Migrations

Define your database model in C# and let EF Core manage migrations:

```csharp
// Create migration after model changes
dotnet ef migrations add AddProductName

// Apply migrations to database
dotnet ef database update

// Roll back to previous migration
dotnet ef database update PreviousMigrationName
```

### Scaffolding from Database

Generate models from existing database:

```csharp
dotnet ef dbcontext scaffold "Server=myserver;Database=mydb" Microsoft.EntityFrameworkCore.SqlServer
```

## Links & Resources

[EF Code First](https://docs.microsoft.com/en-us/ef/ef6/modeling/code-first/workflows/new-database) — Build model classes and generate database from code

[EF Core Migrations](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli) — Manage schema changes through versioned migrations

[EF Fluent API](https://www.learnentityframeworkcore.com/configuration/fluent-api) — Configure advanced model mappings and constraints

[DBUp](https://dbup.readthedocs.io/en/latest/) — Alternative migration tool for SQL scripts with transaction-based execution
