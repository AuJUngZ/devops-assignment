# devops-assignment

## Repository structure

```
|devops-assignment
├── README.md
├── go-service # Simple Go service
│   ├── Dockerfile
│   ├── go.mod
│   ├── main.go
├──argocd # ArgoCD application configuration
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
