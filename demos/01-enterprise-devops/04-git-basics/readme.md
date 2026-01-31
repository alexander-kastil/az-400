# Git Basics: Working with Git locally - Commit, Branching, Merging

## Extensions & Tools

[Git Bash Download](https://git-scm.com/downloads)

[Git Graph VS Code](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)

[Github Pull Request and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)

## Demos

**Configure Git Locally** — Set up your Git identity with user name and email, manage credentials, and configure `.gitignore` rules to prevent tracking unwanted files. These foundational settings ensure commits are attributed correctly and sensitive files remain out of version control.

**Master Core Git Workflow** — Learn essential commands for initializing repositories, staging changes, committing with meaningful messages, and reviewing commit history. This covers the fundamental cycle of tracking changes: `init`, `status`, `add`, and `commit`.

**Branch Management** — Create, list, and switch between branches to organize parallel work streams. Push branches to remote repositories and merge changes back, enabling collaborative development with proper isolation of features.

**Handle Detached HEAD States** — Understand what happens when checking out specific commits and how to recover work by saving the state into a new branch. Useful for inspecting historical code and experimental fixes without affecting the main branch.

**Stash and Switch Safely** — Use `git stash` to temporarily save uncommitted changes before switching branches, preventing loss of work. Apply stashes selectively to different branches, maintaining clean working directories.

**Clean Up Untracked Files** — Remove local artifacts from branch switches using `git clean` with various flags (`-f`, `-fd`, `-fx`) to clean files and folders based on your needs without affecting committed code.

**Sync with Remote** — Keep your local branch up-to-date with remote changes using `git fetch` and `git rebase`, ensuring your work is based on the latest upstream commits.

**Tag Releases** — Create both lightweight and annotated tags to mark important versions. Annotated tags include metadata like author and message, making them ideal for releases. Push tags to remote and manage versions across the codebase.

## Configuration

**Set User and Email**

Configure your identity globally so commits are attributed correctly:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@yourdomain.com"
```

**Unset Credentials**

Remove stored credentials when switching authentication methods:

```bash
git config --global --unset credential.helper
```

**Configure Ignored Files**

Create a `.gitignore` file in the root of your project to exclude files from tracking. Generate patterns for your tech stack at [gitignore.io](https://www.gitignore.io/).

## Basic Git Commands

**Initialize Repository**

```bash
git init
```

**Check Status**

View what's staged, unstaged, or untracked:

```bash
git status
```

**Stage Changes**

Stage all files:

```bash
git add .
```

Stage specific file and all TypeScript files:

```bash
git add file.txt *.ts
```

**Commit Changes**

Save staged changes with a descriptive message:

```bash
git commit -m "your checkin comment"
```

## Status & Updates

**View Commit History**

```bash
git log
```

**Check for Remote Updates**

```bash
git remote update
```

**Review Working Directory Status**

See all additions, deletions, and changes:

```bash
git status
```

## Branching

**List Local and Remote Branches**

View all branches in your repository:

```bash
git branch         # Local branches
git branch -r      # Remote branches
```

**Create a New Branch**

```bash
git branch feature/myfeature
```

**Push Branch to Remote**

```bash
git push origin [name_of_your_new_branch]
```

**Switch Between Branches**

```bash
git checkout [name_of_your_branch]
```

> **Tip**: On Windows, check status with `git status` after switching. Clean untracked files from other branches using `git clean -f`.

**Merge Branches**

Switch to the target branch first, then merge:

```bash
git checkout [target_branch]
git merge [branch_to_merge]
```

## Checkout Specific Commits

**Navigate to a Specific Commit**

Use the commit SHA to inspect historical code:

```bash
git checkout <sha1>
```

Find the SHA in your commit history or using a tool like [Git Graph VS Code](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph).

> **Note**: This creates a detached HEAD state—you're viewing the repository at that point in time without being on a branch.

**Discard Detached HEAD Changes**

Return to your main branch and discard any changes:

```bash
git checkout master
```

**Preserve Detached HEAD Work**

Save your detached work into a new branch to continue development:

```bash
git branch branch-name
git checkout branch-name
```

## Changing Branches

**Stash Work Temporarily**

Save uncommitted changes without committing when you need to switch branches:

```bash
git stash              # or git stash push
git stash list         # View all stashes
git stash apply        # Apply latest stash
git stash apply stash@{2}  # Apply specific stash
```

**Switch to Another Branch**

```bash
git checkout [name_of_your_branch]
```

**Clean Up Local Files**

Remove untracked files left behind from branch switches. Use the flag that fits your needs:

```bash
git clean -f      # Remove untracked files
git clean -fd     # Remove untracked files and directories
git clean -fx     # Remove untracked and ignored files
git clean -n      # Dry run (preview changes)
```

Clean specific folder:

```bash
git clean -f folderpath
```

**Sync Local Branch with Remote**

Update your branch with the latest upstream changes:

```bash
git fetch
git rebase origin/master
```

## Tags

**Create Lightweight Tag**

A simple pointer to a commit:

```bash
git tag v1.1.0
```

**Create Annotated Tag**

Stores full object with author, date, and message (recommended for releases):

```bash
git tag -a v2.0.1 -m "fixed Bug on replaced data layer. do not use v2.0.0"
```

**List and Inspect Tags**

```bash
git tag                # List all tags
git show v2.0.1        # Show details of a specific tag
```

**Push Tags to Remote**

```bash
git push origin v2.0.1     # Push specific tag
git push --tags            # Push all tags
```

**Manage Tags**

```bash
git tag -d v2.0.1      # Delete local tag
git checkout v2.0.1    # Checkout tag
```
