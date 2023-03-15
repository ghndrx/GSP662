# modules/backend/main.tf

variable "project_id" {}
variable "region" {}

module "network" {
  source = "../network"
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "f1-micro"
  zone         = "${var.region}-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = module.network.network_name
  }

  metadata_startup_script = module.network.startup_script
}
