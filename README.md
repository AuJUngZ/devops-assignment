# devops-assignment

## Repository structure

```
|devops-assignment
├── README.md
├── .github # Github Actions workflow for CI/CD
├── go-service # Simple Go service
│   ├── Dockerfile
│   ├── go.mod
│   ├── main.go
├── terraform # Terraform configuration for GKE cluster
├── argocd # ArgoCD application configuration
|   ├── application.yaml
├── kustomize # Kustomize directory for Kubernetes deployment
│   ├── base # Base configuration
│   │   ├── deployment.yaml
│   │   ├── kustomization.yaml
│   │   ├── service.yaml
│   ├── overlays # Overlays for different environments
│   │   ├── dev
│   │   │   ├── kustomization.yaml
│   │   ├── prod
│   │   │   ├── kustomization.yaml
```

### Go Service

In the `go-service` directory, you will find a simple Go service code along with a Dockerfile. This service need some ENV variables to run for kubernetes demonstration purpose. You can build your own Docker image using this command:

```bash
docker build -t simple-go-service:latest ./go-service
```

However, you can also use the Docker image provided in the Docker Hub registry. The image is named `aujung/simple-go-service`. Also, you can click [here](https://hub.docker.com/r/aujung/simple-go-service) to see the Docker Hub page.

### Terraform

In the `terraform` directory, you will find the Terraform configuration files to create a GKE cluster. This configuration includes the necessary resources such as VPC, subnets, and GKE cluster. You can initialize and apply the Terraform configuration using the following commands:

```bash
$ cd terraform
$ terraform init
$ terraform apply
```

### ArgoCD

In this section, you need to install ArgoCD in your Kubernetes cluster. You can follow the official [ArgoCD installation guide](https://argo-cd.readthedocs.io/en/stable/getting_started/) to set it up.
After installing ArgoCD, you can apply the `application.yaml` file located in the `argocd` directory. This file contains the configuration for deploying the `Go service` using ArgoCD using this command:

```bash
kubectl apply -f argocd/application.yaml
```

### Kustomize

In the `kustomize` directory, you will find the base configuration and overlays for different environments. The base configuration includes a deployment and service YAML file. The overlays for `dev` and `prod` environments include their own `kustomization.yaml` files that reference the base configuration.

For different environments, you will see different output when you apply those configurations.

#### Dev Env

![Screenshot 2025-04-22 201508](https://github.com/user-attachments/assets/59b04923-c4ec-4962-bbb2-6b54ab038087)

#### Prod Env

![Screenshot 2025-04-22 201831](https://github.com/user-attachments/assets/66ba02e5-415b-4378-996f-792eb3e12821)

### .github/workflows

In this directory, you will find the Github Actions workflow file for CI/CD. The workflow is triggered on push new tag to the `main` branch with the format `vX.X.X`. The workflow will build the Docker image, push it to Docker Hub [(Image Registry)](https://hub.docker.com/r/aujung/simple-go-service) , and deploy the new version of application to the Kubernetes cluster using ArgoCD via update the `deployment.yaml` file in the `kustomize/base` directory. The workflow will also create a new release in Github with the same tag.

# TL;DR

This demonstration is not a full-fledged CI/CD pipeline. It avoids using gitflow and focuses on the essential components and concepts of gitops, so that you will see everything in a single repository and a single branch.
