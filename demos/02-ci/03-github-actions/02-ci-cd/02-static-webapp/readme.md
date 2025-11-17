# Azure Static Web App / Angular Continuous Integration

[Azure Static Web Apps](https://learn.microsoft.com/en-us/azure/static-web-apps/)

[az staticwebapp](https://learn.microsoft.com/en-us/cli/azure/staticwebapp?view=azure-cli-latest)

## Demo

- Create Static Web App using Azure Portal

    ![static-wa.png](_images/create-static-wa.png)

- Use the following Angular build details:

    ![build-details.png](_images/build-details.png)

## Scripted provisioning

 - You can also create Static Web App using Azure CLI by executing `create-static-webapp.azcli`. 

- For automation in a pipeline you can also use token based authentication

- Set the access token for Github in terminal using: gittoken=YOUR-TOKEN

    ```bash
    az staticwebapp create -n $app -g $grp -s $repo -l $loc -b master --app-location "apps/shop-ui/" --output-location "dist/food-shop-ui" --token $gittoken
    ```

    >Note: Before executing the script set an GitHub access token in your environment using: [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)    