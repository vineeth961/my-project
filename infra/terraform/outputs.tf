output "cluster_name" {
  value = module.eks.cluster_name
}

output "kubeconfig_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

