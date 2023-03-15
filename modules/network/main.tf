# Define VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

# Define subnetwork
resource "google_compute_subnetwork" "vpc_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

# Define firewall rule for frontend instances
resource "google_compute_firewall" "frontend_firewall" {
  name    = "allow-frontend"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["frontend"]
}

# Define firewall rule for backend instances
resource "google_compute_firewall" "backend_firewall" {
  name    = "allow-backend"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }

  target_tags = ["backend"]
}

