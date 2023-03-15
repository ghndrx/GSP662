resource "google_compute_firewall" "fe_firewall" {
  name    = "fw-fe"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["frontend"]
}

resource "google_compute_firewall" "be_firewall" {
  name    = "fw-be"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["backend"]
}