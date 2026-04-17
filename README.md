# Workload Identity Federation in GCP

This repository contains Terraform configuration for deploying a Google Cloud project with:
- VPC, subnet, and firewall configuration
- Compute Engine instance
- Cloud Storage bucket
- Cloud DNS managed zone and A record
- Workload Identity Federation for GitHub Actions
- GitHub Actions workflow for deploying to Cloud Run

## Important files
- `1. Provider.tf` - provider and required APIs configuration
- `2. Outputs.tf` - Terraform outputs, including workload identity provider and service account email
- `3. Variables.tf` - input variable declarations
- `4. Backend.tf` - optional remote backend configuration (commented out)
- `5. VPC.tf` - VPC, subnet, and firewall resources
- `6. Compute.tf` - Compute Engine instance configuration
- `7. Cloud Storage.tf` - Cloud Storage bucket configuration
- `8. Cloud DNS.tf` - DNS managed zone and A record
- `9. Workload Identity.tf` - Workload Identity Federation and GitHub service account resources
- `.github/workflows/deploy.yml` - GitHub Actions workflow for GCP authentication and Cloud Run deployment

## Required Terraform variables
The repository uses `terraform.tfvars` for environment-specific values. Example values in this repo include:

```hcl
project_id = "gcplearning-15042026"
region     = "us-central1"

vpc_name                = "my-custom-vpc-network"
routing_mode            = "REGIONAL"
auto_create_subnetworks = false
allowed_ports           = ["22", "80", "443", "5432", "8080"]

subnet_name   = "primary-subnet-us-central1"
ip_cidr_range = "10.10.1.0/24"

zone         = "us-central1-f"
machine_name = "computeinstance"
machine_type = "e2-standard-4"
```

Additional default variables are declared in `3. Variables.tf`:
- `pool_id` - Workload Identity Pool ID (default: `github-pool`)
- `provider_id` - Workload Identity Provider ID (default: `github-provider`)
- `github_repo` - GitHub repository allowed to use the provider
- `sa_name` - GitHub Actions service account ID (default: `github-actions-sa`)

## GitHub Actions secrets
The workflow in `.github/workflows/deploy.yml` expects the following repository secrets:

- `GCP_PROJECT_ID` - the GCP project ID
- `GCP_WORKLOAD_IDENTITY_PROVIDER` - the full Workload Identity Provider resource name, for example:
  `projects/123456789012/locations/global/workloadIdentityPools/github-pool/providers/github-provider`
- `GCP_SERVICE_ACCOUNT_EMAIL` - the service account email used by GitHub Actions, for example:
  `github-actions-sa@PROJECT_ID.iam.gserviceaccount.com`

## Validation
To validate the Terraform configuration locally:

```bash
terraform init -backend=false -input=false
terraform validate
```

## Notes
- The workload identity provider and service account are declared in `9. Workload Identity.tf`.
- `6. Compute.tf` uses the custom subnet resource `google_compute_subnetwork.primary_subnet`.
- The deploy workflow is configured for Cloud Run and uses the authenticated service account.
