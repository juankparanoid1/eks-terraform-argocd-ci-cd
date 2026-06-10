output "cluster_name" {
  description = "cluster EKS name kubectl"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "server URL Kubernetes"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "group ID assigned to the clúster"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "aws region where was deployed the cluster"
  value       = "us-east-1"
}
