# Cost Optimization Recommendations

## 1. GitHub Repository
- Self-hosted GitHub runners can be considered for private repositories.

## 2. CI Pipeline in Azure DevOps
- Self-hosted agents can be used to avoid additional costs for private repositories.
- Can use caching for dependencies and parallelization to reduce build times.
- open-source tools like jenkins can be used 

## 3. CD Pipeline
- Auto-scaling can be enabled for Azure App Service or AKS.

## 4. Terraform AKS Deployment
- Smaller VM sizes and spot instances can be used for non-production environments.
- Cluster auto-scaling can be enabled for optimal resource utilization.

## 5. Dockerizing Applications
- Multi-stage Dockerfiles can be used to reduce image sizes.
- Docker image pushes can be limited to ACR to only necessary versions.

## 6. Helm Chart and Kubernetes Deployment
- Resource requests and limits for both dev and prod environments can be optimized.
- By using Horizontal Pod Autoscaling and Cluster Autoscaler for AKS.
- Using right sized nodes/vms.

## 7. Monitoring and Alerts
- By setting appropriate retention and alert policies to avoid unnecessary data storage costs.
- By optimizing log queries to reduce execution costs.

## 8. Security in CI/CD Pipelines
- By using free or open-source security tools like SonarQube Community Edition.

## 9. Secrets accessing through Key vault
- By reducing the number of transactions of accessing the key vault secrets.
