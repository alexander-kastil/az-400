# Branching Types

## Links & Resources

[GitFlow](https://danielkummer.github.io/git-flow-cheatsheet/)

[GitHub Flow](https://docs.github.com/en/get-started/quickstart/github-flow)

[Handling Merge Conflicts in VS Code](https://code.visualstudio.com/docs/editor/versioncontrol#_merge-conflicts)

## GitHub Flow

![gitflow](_images/github-flow.jpg)

## Git-Flow

![gitflow](_images/gitflow.png)

> Note: Require GIT 2.24.0+ - Check with `git --version` and separate package installation on Linux `sudo apt-get install -y git-flow`

Initialize repo for gitflow:

```
git flow init
```

Start a new feature:

```
git flow feature start <FEATURE>
```

Finish feature:

```
git flow feature finish <FEATURE>
```

Publish a feature:

```
git flow feature publish  <FEATURE>
```

Start a release:

```
git flow release start <RELEASE>
```

Finish a release:

```
git flow release finish <RELEASE>
```