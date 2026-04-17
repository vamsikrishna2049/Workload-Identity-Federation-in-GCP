# -------------------------------
# Google Cloud Provider Configuration
# -------------------------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# data "google_project" "project" {
#   project_id = var.project_id
# }

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
    "compute.googleapis.com",              # VM, VPC, firewall, routes
    "storage.googleapis.com",              # Cloud Storage
    "dns.googleapis.com",                  # Cloud DNS
    "iam.googleapis.com",                  # IAM & Workload Identity Federation
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager
    "storage.googleapis.com",              # Cloud Storage
  ]
}

# Enable the required APIs for the project
resource "google_project_service" "apis" {
  for_each = toset(local.required_apis)

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}
