# Cloud-Native GitOps & CI/CD Platform Architecture

This repository contains a production-ready Infrastructure as Code (IaC) and Continuous Integration/Continuous Deployment (CI/CD) pipeline based on the **GitOps** methodology. It automates the provisioning of cloud infrastructure on **Amazon Web Services (AWS)** and ensures automated, declarative application delivery into **Amazon EKS**.

The main goal of this project is to showcase modern DevOps and Platform Engineering best practices—eliminating manual configurations (*No ClickOps*) and establishing Git as the single source of truth for both infrastructure and application states.

---

## Tech Stack

* **Cloud Provider:** [Amazon Web Services (AWS)](https://aws.amazon.com/)
* **Container Orchestration:** [Amazon EKS (Elastic Kubernetes Service)](https://aws.amazon.com/eks/)
* **Infrastructure as Code (IaC):** [Terraform](https://www.terraform.io/)
* **Package Management:** [Helm Charts](https://helm.sh/)
* **Continuous Integration (CI):** [GitHub Actions](https://github.com/features/actions)
* **Continuous Delivery (CD / GitOps):** [ArgoCD](https://argoproj.github.io/cd/)
* **Container Registry:** [Docker Hub](https://hub.docker.com/)

---

## Architecture & Workflow

The architecture implements a declarative GitOps workflow where any change in the repository triggers automated building, testing, and reconciliation processes:

```
[ App Code ] ──> [ GitHub Push ] ──> [ GitHub Actions (CI) ] ──> [ Push Docker Hub ]
                                                                          │
[ Desired State (Helm) ] ──> [ Git Repo ] <── [ ArgoCD (Sync Loop) ] <────┘
                                                   │
                                                   └──> [ Reconcile into Amazon EKS ]

```

---

## Repository Structure

```
.
├── .github/workflows/
│   └── ci-cd.yml           # GitHub Actions pipeline workflow (Build & Push)
├── infra/
│   ├── providers.tf        # Providers (AWS, K8s, Helm), VPC, EKS Cluster definitions
    ├── main.tf             # IaC definition
│   └── outputs.tf          # Cluster endpoints, security groups, outputs
└── helm/
    └── go-webapp-chart/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
```

---

### GitHub Secrets Setup

DOCKERHUB_USERNAME: Your Docker Hub username  
DOCKERHUB_TOKEN: Personal Access Token with read/write permissions 
GITHUB_TOKEN: Personal Access token with read/write permission

---

## 🚀 Deployment Guide

### Step 1: Provision Infrastructure
```
cd infra
terraform init
terraform plan
terraform apply
```

### Step 2: Access Kubernetes Cluster
```
aws eks update-kubeconfig --region us-east-1 --name [CLUSTER_NAME]
```

### Step 3: Install webapp using helm
```
cd helm
helm install go-webapp ./go-webapp-chart
```

```
#Check loadbalancer url and test it
kubectl get ingress
```

```
#Uninstall
helm uninstall go-webapp
```

You can access it by navigating to the path ```/courses```

### Step 3: Install argocd

```
kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

```
#check status
kubectl get pods -n argocd
```

```
#Access the Argo CD UI (Loadbalancer service)
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

```
#Get the Loadbalancer service IP and test it
kubectl get svc argocd-server -n argocd
```

```
#Get initial password to login
kubectl get secrets -n argocd
kubectl edit secret argocd-initial-admin-secret -n argocd
```

```
#Due to the password is encode, remember to not copy the last % symbol
echo [PASSWORD] | base64 --decode
```
---