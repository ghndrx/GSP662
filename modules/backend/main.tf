terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "n1-standard-1"
  tags         = ["backend"]

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")

  network_interface {
    network = google_compute_network.backend_network.self_link
    access_config {
      // Allocate a one-to-one NAT IP to allow SSH and HTTP access
    }
  }

  service_account {
    email  = var.sa_email
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_firewall" "backend_firewall" {
  name    = "allow-backend-internal"
  network = google_compute_network.backend_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }

  source_tags = ["backend"]
  target_tags = ["backend"]
}

output "backend_ip" {
  value = google_compute_instance.backend.network_interface[0].access_config[0].nat_ip
}
