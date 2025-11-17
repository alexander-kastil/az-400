# Food App - A Food Ordering Cloud Native Application

- Architecture Diagram:

    ![food-app](_images/app.png)

# App Resources & Setup

- Create the base resources of the app by executing the following Azure CLI script: [create-images.azcli](/app/create-images.azcli). It creates the following resources:

    - Resource Group
    - Key Vault
    - Managed Identity
    - Container Registry
    - Container App Environment
    - Storage Account