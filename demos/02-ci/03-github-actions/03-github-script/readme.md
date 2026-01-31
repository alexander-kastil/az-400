# Using GitHub Script

Demonstrates using the GitHub Script action to interact with GitHub APIs directly from workflows. GitHub Script simplifies working with the Octokit REST API by providing easy access to the GitHub context within a workflow.

## Example: Automated Issue Processing

The [github-script.yml](.github/workflows/github-script.yml) workflow shows how to automatically respond to new issues with both comments and labels.

**Key features:**

- **Trigger on issue events** - Runs automatically when issues are opened
- **Multi-job parallelization** - Executes comment and label operations concurrently
- **GitHub API interactions** - Uses Octokit REST API to manage issues programmatically

```yaml
name: process issues - github script sample

on:
  issues:
    types: [opened]

jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v4
        with:
          script: |
            github.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: ":thumbsup: Thank you for reporting this issue"
            })

  apply-label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v4
        with:
          script: |
            github.issues.addLabels({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              labels: ['needs-classification']
            })
```

## Links & Resources

[GitHub Script](https://github.com/actions/github-script)

[octokit/rest.js](https://octokit.github.io/rest.js/v18)

[GitHub Emoji Cheat Sheet](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md)
