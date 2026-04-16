resource "google_dns_managed_zone" "zone" {
  name     = "my-zone"
  dns_name = "example.com."
}

resource "google_dns_record_set" "a_record" {
  name         = "vm.example.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.zone.name

  rrdatas = [
    google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
  ]
}
