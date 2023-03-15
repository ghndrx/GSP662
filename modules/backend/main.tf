# modules/backend/main.tf

module "network" {
  source = "../network"
  project = var.project_id
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "f1-micro"
  zone         = "${var.region}-f"

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
