# GitHub Actions Basics

GitHub Actions is GitHub's native CI/CD automation platform that runs workflows triggered by repository events. Workflows are YAML files stored in `.github/workflows/` that define jobs, steps, and actions—reusable units of code that automate tasks like building, testing, and deploying applications.

Key concepts include **events** (what triggers a workflow), **runners** (machines where jobs execute), **jobs** (independent tasks that run in parallel), and **steps** (individual commands or actions). You can trigger workflows on push, pull requests, schedules, or manually via `workflow_dispatch`. Built-in actions like `actions/checkout@v4`, `actions/setup-dotnet@v4`, and community actions extend functionality without reinventing the wheel.

Workflows integrate seamlessly with GitHub—accessing repository secrets, checking out code, and reporting results directly on pull requests and deployments. They're ideal for automating repetitive DevOps tasks while keeping all automation code versioned alongside your application source.

## Links & Resources

[Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

[Events that trigger workflows](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows)
