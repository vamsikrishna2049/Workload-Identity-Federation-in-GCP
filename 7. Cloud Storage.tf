# # -------------------------------
# # Google Cloud Storage Bucket
# # -------------------------------

# resource "google_storage_bucket" "bucket" {
#   name                        = "gcplearning-15042026" # Must be globally unique across all GCP projects
#   location                    = "US"                   # Choose a location for the bucket (e.g., US, EU, ASIA)
#   uniform_bucket_level_access = true                   # Enforce uniform access control at the bucket level
#   force_destroy               = true                   # Allow bucket deletion even if it contains objects (use with caution)
#   depends_on                  = [google_project_service.apis]
#   #depends_on    = [google_project_service.storage_api] General Scenario

#   versioning {
#     enabled = true # Enable versioning to keep multiple versions of objects in the bucket
#   }
# }