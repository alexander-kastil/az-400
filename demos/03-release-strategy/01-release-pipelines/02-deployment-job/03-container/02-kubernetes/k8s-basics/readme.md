# Create and use a cluster on Azure Kubernetes Services

Demonstrates deploying containerized applications to Azure Kubernetes Service (AKS) using Kubernetes manifests. The demo shows how to provision an AKS cluster and deploy both API and UI services with LoadBalancer exposure.

## Demo Overview

**Provision AKS Cluster** using [create-k8s.azcli](create-k8s.azcli)

The script sets up a single-node AKS cluster and deploys two services:

```bash
env=k8s
grp=az400-m03-$env
loc=westeurope
aks=foodcluster-$RANDOM
app=catalog-api

# Create resource group and AKS cluster
az group create -n $grp -l $loc
az aks create -g $grp -n $aks --node-count 1 --generate-ssh-keys
az aks get-credentials -g $grp -n $aks

# Create namespace and deploy services
kubectl create namespace $env
kubectl apply -f foodapi.yaml --namespace $env
kubectl apply -f foodui.yaml --namespace $env

# Verify deployments
kubectl get deployment $app -n $env
kubectl get pods -n $env
kubectl get service $app -n $env
```

|                              |                                                                                                                                                                                                   |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [foodapi.yaml](foodapi.yaml) | Deploys the catalog API service with:<br>- Single replica with resource limits (1 CPU, 50Mi memory)<br>- LoadBalancer service exposing port 8081<br>- Container image: `alexander-kastil/foodapi` |
| [foodui.yaml](foodui.yaml)   | Deploys the food shop UI with:<br>- Single replica with resource limits (500m CPU, 128Mi memory)<br>- LoadBalancer service exposing port 8081<br>- Container image: `alexander-kastil/foodui`     |

Once deployed, access the services via the LoadBalancer IP addresses obtained from `kubectl get service`. Example: `http://<EXTERNAL-IP>:8081`

## Links & Resources

[Azure Kubernetes Service Documentation](https://learn.microsoft.com/azure/aks/)

[Kubernetes Documentation](https://kubernetes.io/docs/)
