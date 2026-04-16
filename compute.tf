# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "vm" {
  depends_on = [google_project_service.apis]
  boot_disk {
    auto_delete = true
    device_name = "jenkins"

    # The initialize_params block is used to specify the source image and disk type for the boot disk.
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20260413"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  # can_ip_forward allows the instance to send and receive packets with non-matching destination or source IPs. This is typically used for instances that are acting as routers or firewalls. In this case, we set it to false since our instance is not intended to perform such functions. 
  can_ip_forward      = false
  deletion_protection = false

  # Labels are key-value pairs that can be used to organize and categorize resources. 
  # In this case, we are adding a label with the key "goog-ec-src" and the value "vm_add-tf". This can help us identify that this VM instance was created using Terraform.
  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = var.machine_type
  name         = var.machine_name

  # The network_interface block is used to configure the network settings for the instance.
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/${var.project_id}/regions/${var.region}/subnetworks/default"
  }

  # reservation_affinity is used to specify the reservation that the instance should use. 
  # In this case, we set it to "ANY_RESERVATION", which means that the instance can use any available reservation in the project. This allows for more flexibility in scheduling the instance, as it can take advantage of any existing reservations without being tied to a specific one.
  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  # The scheduling block is used to configure the scheduling options for the instance.
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  #  service_account {
  #    email  = "516656217194-compute@developer.gserviceaccount.com"
  #    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  #  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = var.zone
}