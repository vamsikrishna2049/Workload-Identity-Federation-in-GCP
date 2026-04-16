terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.28.0"
    }
  }
}

provider "google" {
  project     = var.project_id                
  region      = var.region
}

terraform {
  backend "gcs" {
    bucket = "gcplearning-15042026"
    prefix = "terraform/state"
  }
}
