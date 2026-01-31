# Provision to Azure Container Apps

- Ensure that the image for the container app is built and pushed to a container registry.

- [catalog-cd-aca.yml](/.azdo/catalog-cd-aca.yml) demonstrates a CD pipeline that builds a Docker image for the .NET Catalog API and deploys it to Azure Container Apps. Uses workload identity federation for secure authentication.

- [angular-ci-cd-aca.yml](/.azdo/angular-ci-cd-aca.yml) demonstrates a CI/CD pipeline that builds the Angular application into a Docker image and deploys the containerized app to Azure Container Apps. Includes multi-stage build optimization in the Dockerfile for reduced image size.

- [payment-func-py-ci-cd-aca.yml](/.azdo/payment-func-py-ci-cd-aca.yml) demonstrates a pipeline that containerizes a Python Azure Function and deploys it to Azure Container Apps with configurable replica scaling (min/max replicas). Uses template-based build steps for reusability.
