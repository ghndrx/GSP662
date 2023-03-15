provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = var.network_name
    access_config {
      // Allocate a one-to-one NAT IP to the instance
    }
  }

  metadata_startup_script = file(var.startup_script_path)

  tags = ["http-server"]
}

output "frontend_ip" {
  value = google_compute_instance.frontend.network_interface.0.access_config.0.nat_ip
}
