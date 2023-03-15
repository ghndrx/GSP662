provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_compute_image" "debian" {
  family  = "debian-10"
  project = "debian-cloud"
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "e2-small"
  zone         = var.region

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
    }
  }

  network_interface {
    subnetwork = module.network.subnet_name
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = module.network.startup_script
}
