# -------------------------------
# VPC Network
# -------------------------------
resource "google_compute_network" "custom_vpc" {
  name        = var.vpc_name
  description = "My custom VPC for application deployment."

  auto_create_subnetworks      = var.auto_create_subnetworks
  routing_mode                 = var.routing_mode
  bgp_best_path_selection_mode = "LEGACY"
  depends_on                   = [google_project_service.apis]
}

# -------------------------------
# Subnet
# -------------------------------
resource "google_compute_subnetwork" "primary_subnet" {
  name    = var.subnet_name
  region  = var.region
  network = google_compute_network.custom_vpc.id

  ip_cidr_range = var.ip_cidr_range
  stack_type    = "IPV4_ONLY"
}

# -------------------------------
# Firewall Rule (Allow Traffic)
# -------------------------------
resource "google_compute_firewall" "allow_ingress" {
  name        = "${var.vpc_name}-allow-ingress"
  depends_on  = [google_project_service.apis]
  description = "Allow TCP traffic on ports 22, 80, 443, 5432, 8080"

  network   = google_compute_network.custom_vpc.name
  direction = "INGRESS"
  priority  = 65534

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "5432", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}
