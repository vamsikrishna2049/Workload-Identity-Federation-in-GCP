# Service Account for GitHub Actions
resource "google_service_account" "terraform_sa" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

# IAM Binding to allow the service account to impersonate the workload identity provider
resource "google_service_account_iam_member" "github_wif_binding" {
  service_account_id = google_service_account.terraform_sa.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${var.github_repo}"
}

# Grant the service account permissions to manage resources (e.g., Editor role)
resource "google_project_iam_member" "terraform_permissions" {
  project = var.project_id
  role    = "roles/editor" # Replace with fine-grained roles in prod
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}