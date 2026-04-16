terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.28.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# terraform {
#   backend "gcs" {
#     bucket = "gcplearning-15042026"
#     prefix = "terraform/state"
#   }
# }


locals {
  required_apis = [
    "compute.googleapis.com", # VM, VPC, firewall, routes
    "storage.googleapis.com", # Cloud Storage
    "dns.googleapis.com",     # Cloud DNS
  ]
}

<<<<<<< HEAD

locals {
  required_apis = [
    "compute.googleapis.com",        # VM, VPC, firewall, routes
    "storage.googleapis.com",        # Cloud Storage
    "dns.googleapis.com",            # Cloud DNS
  ]
}

=======
>>>>>>> 82f120d (InfraCreated)
resource "google_project_service" "apis" {
  for_each = toset(local.required_apis)

  project = var.project_id
  service = each.value

  disable_on_destroy = false
<<<<<<< HEAD
}
=======
}
>>>>>>> 82f120d (InfraCreated)
