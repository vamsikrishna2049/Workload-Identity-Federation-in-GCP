output "vpc_name" {
  value = google_compute_network.custom_vpc.name
}

# Compute IP Address
output "compute_instance_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

# Output the name servers for the managed zone 
output "name_servers" {
  value = google_dns_managed_zone.zone.name_servers
}

# Output the name of the storage bucket
output "storageName" {
  value = google_storage_bucket.bucket.name
}

output "service_account_email" {
  value = google_service_account.terraform_sa.email
}

output "workload_identity_provider" {
  value = "projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/providers/github"
}