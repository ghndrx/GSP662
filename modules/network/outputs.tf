output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_name" {
  value = google_compute_subnetwork.vpc_subnet.name
}

output "subnet_cidr_range" {
  value = google_compute_subnetwork.vpc_subnet.ip_cidr_range
}

output "frontend_firewall_name" {
  value = google_compute_firewall.frontend_firewall.name
}

output "backend_firewall_name" {
  value = google_compute_firewall.backend_firewall.name
}
