# .NET Build & Deployment using GitHub Action

[Manually running a workflow](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow)

## Demo

- Execute `provision-catalog-api-webapp.azcli`

- Update Publishing Profile in [Secrets](https://github.com/alexander-kastil/food-app/settings/secrets/actions)

- Explain [.github/workflows/catalog-api-cicd.yml](https://github.com/alexander-kastil/food-app/blob/master/.github/workflows/catalog-api-cicd.yml) of repo. Also mention the dispatch trigger

    ```yaml 
    name: catalog-api-cicd

    on:
    push:
        branches:
        - master
        paths:
        - apps/catalog-api/api/**

    workflow_dispatch:
        inputs:
        logLevel:
            description: 'Log level'     
            required: true
            default: 'warning' 
            type: choice
            options:
            - info
            - warning
            - debug 
        tags:
            description: 'Test scenario tags'
            required: false 
            type: boolean
        environment:
            description: 'Environment to run tests against'
            type: environment
            required: true       
    env:
        Appservice: catalog-api-github-actions

    jobs:
    build-and-deploy:
        runs-on: ubuntu-latest

        steps:
        - uses: actions/checkout@master

        - name: Set up .NET Core
            uses: actions/setup-dotnet@v1
            with:
            dotnet-version: "8.0.x"

        - name: Build with dotnet
            run: dotnet build ${{ github.workspace }}/apps/catalog-api/api/catalog-api.csproj --configuration Release

        - name: dotnet publish
            run: dotnet publish ${{ github.workspace }}/apps/catalog-api/api/catalog-api.csproj -c Release -o ${{env.DOTNET_ROOT}}/api
                            
        - name: Deploy to Azure Web App
            uses: azure/webapps-deploy@v2
            with:
            app-name: ${{ env.Appservice }}
            publish-profile: ${{ secrets.CATALOG_API_PROFILE }}
            package: ${{env.DOTNET_ROOT}}/api
    ```

- Run workflow Build .NET Core Api & Deploy Food Api
