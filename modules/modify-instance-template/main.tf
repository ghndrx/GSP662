# Change machine type of frontend instance
resource "google_compute_instance" "frontend" {
  name = "frontend"
  zone = "us-central1-f"
  machine_type = "custom-4-3840"
}

# Create a new instance template for the frontend instances
resource "google_compute_instance_template" "fancy_fe_new" {
  name = "fancy-fe-new"
  source_instance = google_compute_instance.frontend.self_link
  source_instance_zone = google_compute_instance.frontend.zone

  disk {
    source = google_compute_instance.frontend.boot_disk[0].source
    auto_delete = true
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.fancy_lb_ip.address
    }
  }
}

# Update the instance group with the new instance template
resource "google_compute_region_instance_group_manager_rolling_update" "fancy_fe_mig_update" {
  name = "fancy-fe-mig-update"
  region = "us-central1"

  managed_instance_group = google_compute_instance_group_manager.fancy_fe_mig.self_link

  version {
    name = "fancy-fe-new"
    instance_template = google_compute_instance_template.fancy_fe_new.self_link
  }

  # Optional flags
  max_surge = 1
  max_unavailable = 1
}


# ENABLE CDN
resource "google_compute_backend_service" "fancy_fe_frontend" {
  name = "fancy-fe-frontend"
  port_name = "frontend"
  protocol = "HTTP"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  backend {
    group = google_compute_instance_group_manager.fancy_fe_mig.self_link
  }

  health_checks = [
    google_compute_http_health_check.fancy_fe_frontend_hc.self_link
  ]

  enable_cdn = true
}