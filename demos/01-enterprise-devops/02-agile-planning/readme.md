# Plan Agile with GitHub Projects and Azure Boards

## Links & Resources

[Azure Boards documentation](https://docs.microsoft.com/en-us/azure/devops/boards/?view=azure-devops)

[Azure Boards Glossary](https://learn.microsoft.com/en-us/azure/devops/project/navigation/glossary?view=azure-devops)

[Connect Azure Boards to GitHub](https://learn.microsoft.com/en-us/azure/devops/boards/github/connect-to-github?view=azure-devops)

## Tools and Extensions

[GitHub Azure Boards App](https://github.com/marketplace/azure-boards)

[GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)

[GitHub Actions: Issues to Azure DevOps](https://github.com/marketplace/actions/github-issues-to-azure-devops).

[Sync Pull Requests to Azure Boards](https://github.com/marketplace/actions/sync-pull-requests-to-azure-boards)

## Demos

- Connect Azure Boards and GitHub Issues
- Add Status Badge to README.md using the boards settings
- Add a work item in ADO Boards and note the Task ID. Make some code changed in the cloned repo and commit the changes using the `AB#<TASK_ID>` notation in the commit message.
- GitHub Actions: Use sync issues action
- Create an Issue from within VS Code 

---
### Connect Azure Boards and GitHub Issues

There are two options to connect Azure Boards and GitHub Issues:

#### Setup Connection using GitHub App

- In Azure DevOps, navigate to the project settings and add a new GitHub connection to your GitHub repo. Alternatively install the [Azure Boards](https://github.com/marketplace/azure-boards) App from the marketplace

- In GitHub, navigate to the https://github.com/settings/profile, configure Azure Boards and check the installation using the configure button. 

- Select the organization and the project.

#### Setup Connection using  PAT Tokens

Create two PAT tokens. One for Azure DevOps and on for GitHub and store them as secrets:

- `ADO_PERSONAL_ACCESS_TOKEN`
  - Azure DevOps | User settings | Security | Personal access tokens
  - repo permissions

- `GH_PERSONAL_ACCESS_TOKEN`
  - GitHub | Personal settings | Developer settings | Personal access tokens
  - read / write

---
### GitHub Actions: Use sync issues action

- On the GitHub marketplace search for these extensions: 

[GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)

[GitHub Issues to Azure DevOps](https://github.com/marketplace/actions/github-issues-to-azure-devops).

[Sync Pull Requests to Azure Boards](https://github.com/marketplace/actions/sync-pull-requests-to-azure-boards)

- Generate a PAT token for the ADO and persist it to the repo settings as secret.

- `ADO_SYNC_TOKEN`
  - Azure DevOps | User settings | Security | Personal access tokens
  - read / write for work items

- Generate a PAT token for the GH and persist it to the repo settings as secret.

- `GH_SYNC_TOKEN`
  - GitHub | Personal settings | Developer settings | Personal access tokens
  - repo permissions

- Add the following workflow in GitHub:

  ```yaml
  name: Export Issues to Azure DevOps Boards
  on:
    issues:
      types:
        [opened, edited, deleted, closed, reopened, labeled, unlabeled, assigned]
  jobs:
    alert:
      runs-on: ubuntu-latest
      steps:
        - name: GitHub Issues to Azure DevOps
          uses: danhellem/github-actions-issue-to-work-item@v2.0
          env:
            ado_token: "${{ secrets.ADO_SYNC_TOKEN }}"
            github_token: "${{ secrets.GH_SYNC_TOKEN }}"
            ado_organization: "integrations-training"
            ado_project: "az-400-next"
            ado_wit: "Issue"
            ado_new_state: "New"
            ado_active_state: "Active"
            ado_close_state: "Closed"
            ado_bypassrules: true
            log_level: 100
  ```

---
### Create an Issue from within VS Code

- Install the [GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github) Extension in VS Code and add an issue using F1 and `Create Issue From Selection`.

  ![create-issue](./_images/create-issue.png)

- Wait until the issue is synced to ADO Boards.  
