resource "google_storage_bucket" "bucket" {
  name          = "gcplearning-15042026"
  location      = "US"
  force_destroy = true
  depends_on    = [google_project_service.apis]
  #depends_on    = [google_project_service.storage_api] General Scenario
}