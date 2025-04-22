# devops-assignment

## Repository structure

```
|devops-assignment
├── README.md
├── go-service # Simple Go service
│   ├── Dockerfile
│   ├── go.mod
│   ├── main.go
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

### Kustomize

In the `kustomize` directory, you will find the base configuration and overlays for different environments. The base configuration includes a deployment and service YAML file. The overlays for `dev` and `prod` environments include their own `kustomization.yaml` files that reference the base configuration.

For different environments, you will see different output when you apply those configurations.
