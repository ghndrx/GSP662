resource "google_compute_firewall" "fe_firewall" {
  name    = "fw-fe"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["frontend"]
}

resource "google_compute_firewall" "be_firewall" {
  name    = "fw-be"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }

  target_tags = ["backend"]
}
