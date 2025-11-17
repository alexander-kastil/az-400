# Node based Azure Function Deployment using yaml

## Demos

- Implements Typescript based DoDouble Function
- Multistage Pipeline with build, provision and deployment

Source Code located at [/src/functions/utils-ts/](/src/functions/utils-ts/)

- Execute Provisioning Script

    ```bash
    env=dev
    grp=az400-$env
    loc=westeurope
    app=utils-func-$env
    storage=utilsfunc$env

    az group create -n $grp -l $loc

    az storage account  create -n $storage -g $grp --sku Standard_LRS

    az functionapp create -n $app -g $grp --storage-account $storage --consumption-plan-location $loc --runtime node --runtime-version 18 --functions-version 4
    ```

- Create a Service Connection of type Azure Resource Manager 

- Pipeline to import / execute: `func-cicd.yaml`