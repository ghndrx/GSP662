## Firewall Rules to allow Front-End and Back-End

resource "google_compute_firewall" "fw_fe" {
  name    = "fw-fe"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  target_tags = ["frontend"]
}

resource "google_compute_firewall" "fw_be" {
  name    = "fw-be"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["8081-8082"]
  }
  target_tags = ["backend"]
}
