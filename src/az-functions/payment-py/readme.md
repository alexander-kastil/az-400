# Azure Functions Python Docker Commands

## Build the Docker image

```powershell
docker build -t payment-function .
```

## Run the container locally

```powershell
docker run -p 8080:80 payment-function
```

## Run with environment variables (if needed)

```powershell
docker run -p 8080:80 -e AzureWebJobsStorage="UseDevelopmentStorage=true" payment-function
```

## Test the function

After running the container, you can test it at:

- http://localhost:8080/api/process_payment

## Build and push to Azure Container Registry (ACR)

```powershell
# Tag for ACR
docker tag payment-function <your-acr-name>.azurecr.io/payment-function:latest

# Push to ACR
docker push <your-acr-name>.azurecr.io/payment-function:latest
```

## Deploy to Azure Container Apps or Azure Functions

The containerized function can be deployed to:

- Azure Container Apps
- Azure Functions Premium Plan with custom containers
- Azure Kubernetes Service (AKS)
