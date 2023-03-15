resource "google_compute_backend_service" "fancy_backend_service" {
  name = "fancy-backend-service"
  protocol = "HTTP"
  
  backend {
    group = google_compute_instance_group_manager.fancy_be_mig.self_link
  }
  
  health_checks = [
    google_compute_http_health_check.fancy_be_hc.self_link
  ]
  
  port_name = "orders"
  
  named_port {
    name = "orders"
    port = "8081"
  }
  
  named_port {
    name = "products"
    port = "8082"
  }
}

resource "google_compute_backend_service" "fancy_frontend_service" {
  name = "fancy-frontend-service"
  protocol = "HTTP"
  
  backend {
    group = google_compute_instance_group_manager.fancy_fe_mig.self_link
  }
  
  health_checks = [
    google_compute_http_health_check.fancy_fe_hc.self_link
  ]
  
  port_name = "frontend"
  
  named_port {
    name = "frontend"
    port = "8080"
  }
}

resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080-8081"]
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
}