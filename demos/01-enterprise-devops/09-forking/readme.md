# Forking Workflow

## Demos

**Understand Forking Fundamentals** — Learn how to fork a repository on GitHub to create your own copy under your account. This is essential for contributing to projects you don't own directly, enabling you to make changes independently and then propose them back to the original project through pull requests.

**Configure Upstream and Origin Remotes** — Set up your fork with two remote repositories: `origin` pointing to your fork and `upstream` pointing to the original repository. This dual-remote setup enables you to track both your personal fork and the original project, allowing you to stay synchronized with upstream changes while maintaining your own version.

**Sync with Upstream Updates** — Keep your fork current with the original repository by fetching updates from upstream and rebasing your local work. This workflow prevents your fork from diverging too far and ensures your pull requests are based on the latest code, reducing merge conflicts and maintaining compatibility.

**Foster Internal Open Source** — Embrace a forking workflow for distributed team collaboration, enabling contributors to propose changes via pull requests without direct write access to the main repository. This creates a transparent, review-driven development model that scales across teams and organizations.

## Workflow Overview

![Forking workflow showing origin and upstream repositories](_images/forking-workflow.jpg)

Example: Working with the class material repository at `https://github.com/alexander-kastil/az-400`, where `alexander-kastil` is the original owner and `az-400` is the repository name.

## Listing Current Remotes

View your configured remote repositories:

```
git remote -v
> origin    https://github.com/your-github-username/reponame.git (fetch)
> origin    https://github.com/your-github-username/reponame.git (push)
```

## Adding the Original Repository as Upstream

Configure the original repository as your upstream source:

```
git remote add upstream https://github.com/original-owner-github-username/reponame.git
```

Verify both remotes are configured:

```
git remote -v
> origin    https://github.com/your-github-username/reponame.git (fetch)
> origin    https://github.com/your-github-username/reponame.git (push)
> upstream  https://github.com/original-owner-github-username/reponame.git (fetch)
> upstream  https://github.com/original-owner-github-username/reponame.git (push)
```

## Syncing Your Fork with Upstream

Fetch the latest updates from the original repository and rebase your changes:

```bash
git fetch upstream
git rebase upstream/main
git push origin
```

For merge-based workflows, replace `rebase` with `merge`:

```bash
git fetch upstream
git merge upstream/main
git push origin main
```
