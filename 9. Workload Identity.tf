resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-pool-${random_id.suffix.hex}"
  display_name              = "GitHub Actions Pool"
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"

  display_name = "GitHub Provider"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
  }
}

resource "google_service_account" "terraform_sa" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

resource "google_service_account_iam_member" "github_wif_binding" {
  service_account_id = google_service_account.terraform_sa.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/attribute.repository/${var.github_repo}"

  depends_on = [
    google_iam_workload_identity_pool_provider.github_provider
  ]
}

resource "google_project_iam_member" "terraform_permissions" {
  project = var.project_id
  role    = "roles/editor" # tighten later
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}