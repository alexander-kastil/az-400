# Forking Workflow

Example: Getting Updates for Class Material

![forking-wf](_images/forking-workflow.jpg)

Original Repo could be: `https://github.com/alexander-kastil/az-400` where `alexander-kastil` is the `original-owner-github-username` and `az-400` is the `reponame`

## Listing the current remotes

List the current configured remote repository for your fork.

```
git remote -v
> origin  https://github.com/your-github-username/reponame.git (fetch)
> origin  https://github.com/your-github-username/reponame.git (push)
```

Specify a new remote upstream repository that will be synced with the fork.

## Adding the repo of the original owner as upstream

```
git remote add upstream https://github.com/original-owner-github-username/reponame.git
```

Verify the new upstream repository you've specified for your fork.

```
git remote -v
> origin    https://github.com/your-github-username/reponame.git (fetch)
> origin    https://github.com/your-github-username/reponame.git (push)
> upstream  https://github.com/original-owner-github-username/reponame.git (fetch)
> upstream  https://github.com/original-owner-github-username/reponame.git (push)
```

## Fetching Updates

Fetch from Upstream:

```
 git fetch upstream
 git merge upstream/master
 git push origin master
```

## Fostering Internal Open Source

Forking is done using the Fork Button

![forking-workflow](_images/forking-workflow.jpg)

Add the repo your forked from as "upstream":

```
git remote add upstream <upstream_url>
```

Make changes an create a Pull Request

Sync your fork to latest:

```bash
git fetch upstream master
git rebase upstream/master
git push origin
```