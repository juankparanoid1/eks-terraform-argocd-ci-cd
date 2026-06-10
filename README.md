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

aws eks update-kubeconfig --region us-east-1 --name [CLUSTER_NAME]

### Step 3: GitOps Verification (ArgoCD)

kubectl get pods -n argocd  
kubectl get applications -n argocd  

---