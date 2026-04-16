# Configure Terraform to use Google Cloud Storage as the backend for storing the state file.
# This allows for better collaboration and state management when working with Terraform in a team environment.

# terraform {
#   backend "gcs" {
#     bucket = "gcplearning-15042026"
#     prefix = "terraform/state"
#   }
# }