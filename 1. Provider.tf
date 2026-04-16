# -------------------------------
# Google Cloud Provider Configuration
# -------------------------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# -------------------------------
# Enable required APIs
# -------------------------------
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.28.0"
    }
  }
}

# Enable APIs required for the project
locals {
  required_apis = [
    "compute.googleapis.com", # VM, VPC, firewall, routes
    "storage.googleapis.com", # Cloud Storage
    "dns.googleapis.com",     # Cloud DNS
  ]
}

# Enable the required APIs for the project
resource "google_project_service" "apis" {
  for_each = toset(local.required_apis)

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}
