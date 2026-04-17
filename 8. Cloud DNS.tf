# -------------------------------
# Cloud DNS Configuration
# -------------------------------
resource "google_dns_managed_zone" "zone" {
  name     = "practise-buzz-zone"
  dns_name = "practise.buzz."
}

# Create an A record pointing to the VM's external IP
resource "google_dns_record_set" "root" {
  name         = "practise.buzz." # Must end with a dot to indicate it's a fully qualified domain name
  type         = "A"              # Record type A for IPv4 addresses
  ttl          = 300
  managed_zone = google_dns_managed_zone.zone.name
  depends_on   = [google_dns_managed_zone.zone, google_compute_instance.vm]

  # The rrdatas field must be a list, so we wrap the single IP address in square brackets
  rrdatas = [
    google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
  ]
}

# What is rrdatas?
# rrdatas is the actual value DNS returns—like IP address for A record or hostname for CNAME.
