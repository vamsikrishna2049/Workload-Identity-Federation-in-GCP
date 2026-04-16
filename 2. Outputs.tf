# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorial

# Output the name of the VPC
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
