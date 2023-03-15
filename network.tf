terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.86.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source      = "./network"
  project_id  = var.project_id
  region      = var.region
  network_cidr= var.network_cidr
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = module.network.network_name

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = var.startup_script
  tags = ["backend"]
}

resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = module.network.network_name

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = var.startup_script
  tags = ["frontend"]
}

resource "google_compute_firewall" "fw_fe" {
  name    = "fw-fe"
  network = module.network.network_name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["frontend"]
}

resource "google_compute_firewall" "fw_be" {
  name    = "fw-be"
  network = module.network.network_name

  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }

  source_tags = ["backend"]
}
