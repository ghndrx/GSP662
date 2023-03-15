resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.source_ranges
}
