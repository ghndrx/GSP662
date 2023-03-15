provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = var.subnet_cidr_range
}

resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = google_compute_network.vpc_network.self_link

  bgp {
    asn = 64514
  }

  dynamic "interface" {
    for_each = var.router_interfaces
    content {
      name               = interface.value.name
      ip_address         = interface.value.ip_address
      management        = interface.value.management
      management_config = interface.value.management_config
    }
  }
}

resource "google_compute_address" "nat_ip" {
  name         = var.nat_ip_name
  region       = var.region
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "nat_instance" {
  name         = var.nat_instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["nat"]
  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.nat_ip.address
    }
  }
}

resource "google_compute_route" "nat_route" {
  name                   = var.nat_route_name
  destination_range      = var.destination_range
  next_hop_instance      = google_compute_instance.nat_instance.self_link
  next_hop_instance_zone = var.zone
  tags                   = ["nat"]
}

output "nat_ip_address" {
  value = google_compute_address.nat_ip.address
}
