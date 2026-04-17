# resource "google_iam_workload_identity_pool" "github_pool" {
#   project                   = var.project_id
#   workload_identity_pool_id = var.pool_id
#   display_name              = "GitHub Actions Pool"
# }

# resource "google_iam_workload_identity_pool_provider" "github_provider" {
#   project                            = var.project_id
#   workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
#   workload_identity_pool_provider_id = var.provider_id
#   display_name                       = "GitHub Provider"

#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }

#   attribute_mapping = {
#     "google.subject"       = "assertion.sub"
#     "attribute.repository" = "assertion.repository"
#     "attribute.ref"        = "assertion.ref"
#   }

#   attribute_condition = "attribute.repository == \"${var.github_repo}\""
# }

# resource "google_service_account" "github_sa" {
#   account_id   = var.sa_name
#   display_name = "GitHub Actions SA"
# }

# resource "google_service_account_iam_binding" "wif_binding" {
#   service_account_id = google_service_account.github_sa.name
#   role               = "roles/iam.workloadIdentityUser"

#   members = [
#     "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.pool_id}/attribute.repository/${var.github_repo}"
#   ]
# }

# resource "google_project_iam_member" "cloudrun_deployer" {
#   project = var.project_id
#   role    = "roles/run.admin"
#   member  = "serviceAccount:${google_service_account.github_sa.email}"
# }

# resource "google_project_iam_member" "artifact_registry" {
#   project = var.project_id
#   role    = "roles/artifactregistry.writer"
#   member  = "serviceAccount:${google_service_account.github_sa.email}"
# }