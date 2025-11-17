# Git Basics: Working with Git locally - Commit, Branching, Merging

## Extensions & Tools

[Git Bash Download](https://git-scm.com/downloads)

[Git Graph VS Code](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)

[Github Pull Request and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)

## Demos 

1. Demonstrate basic Git commands

## Configuration

Set User and E-Mail

```
git config --global user.name "Your Name"
git config --global user.email "your.email@yourdomain.com
```

Unset Credentials

```
git config --global --unset credential.helper
```

## Configure ignored files

To Configure ignored files add a `.gitignore` file to the root of your project. A valid `.gitignore` file can be generated at https://www.gitignore.io/

## Basic Git Commands

Init Git:

```
git init
```

Get Status

```
git status
```

Stage all files:

```
git add .
```

Stage a specific file and all TypeScript files:

```
git add file.txt | *.ts
```

Commit files:

```
git commit -m "your checkin comment"
```

## Status & Updates

Show Commit logs:

```
git log
```

Check for remote updates:

```
git remote update
```

Show Status (Adds/Delets/Changes):

```
git status
```

## Branching

List Branches:

```
git branch
```

List remote branches:

```
git branch -r
```

Create Branch:

```
git branch feature/myfeature
```

Push new Branch to remote:

```
git push origin [name_of_your_new_branch]
```

Switch to Branch:

```
git checkout [name_of_your_branch]
```

> Note: When switching branches it is always good advice to check the status with `git status` on a windows machine. When there are changes from other branches on the disk you can clean the branch using `git clean -f`

Merge Branch:

```
git merge [branch_to_merge]
```

> Note: You might have to switch to the branch that you might want to merge into befor executing merge

## Checkout specific Commits

Get a spcific Commit:

```
git checkout <sha1>
```

sha1:

![commits](_images/commits.png)

![sha1](_images/sha1.png)

> Note: This will result in a detached Head.

If you want to delete your changes associated with the detached HEAD:

```
git checkout master
```

If you want to keep the detached state save it into a new branch and continue from there:

```
git branch branch-name
```

> Note: You will have to switch to the branch you saved to afterwards

## Changing Branches

Saving work befor switching the branch - alternative to stage and commit:

```
git stash | git stash push
```

List stashes:

```
git stash list
```

Use a stash:

```
git stash apply | git stash apply stash@{2}
```

Switch to Branch:

```
git checkout [name_of_your_branch]
```

Cleaning up after branch switches - ie to remove untracked files from other branches on local disk:

-n flag is used to perform dry run.
-f flag is used to remove untracked files.
-fd flag is used to remove untracked files and folders.
-fx flag is used to remove untracked and ignored files.

```
git clean -fd | git clean -f folderpath 
```

Update a Branch from master / main:

```
git fetch
git rebase origin/master
```

## Tags

Create Lightweight tag :

```
git tag -l v1.1.0
```

Create Annotated tag :

```
git tag -a v2.0.1 -m "fixed Bug on replaced data layer. do not use v.2.0.0"
```

List all tags:

```
git tag
```

Show a specific tag:

```
git show v2.0.1
```

Push tags to Remote:

```
git push origin v2.0.1 | git push --tags
```

Delete tag:

```
git tag -d v2.0.1
```

Checkout tag:

```
git checkout 2.0.1
```