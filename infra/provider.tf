terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.2.0"
    }
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "aws" {
  region = "us-east-1"
}

# Configuración del proveedor de Kubernetes conectada a tu módulo de EKS
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Configuración del proveedor de Helm usando la misma conexión de Kubernetes
provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
