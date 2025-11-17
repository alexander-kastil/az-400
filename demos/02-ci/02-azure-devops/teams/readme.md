# Teams Tab using SharePoint Framework (SPFx) Continuous Integration

Uses SPFx Sample Repo [https://github.com/alexander-kastil/teams-devops](https://github.com/alexander-kastil/teams-devops)

## Scaffolding & Basics

SPFx (SharePoint Framework) requires [Node 16+](https://nodejs.org/en/download/releases/), Yeoman, Gulp, SPFx Generator SharePoint

```
npm i -g yo gulp @microsoft/generator-sharepoint
```

> Note: Detailed Instructions for Env Setup [here](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-development-environment)

Create proj:

```
yo @microsoft/sharepoint
```

Manual Build:

```
npm i
gulp bundle
gulp package-solution
```

Show `deploy/teams-ci.yml`