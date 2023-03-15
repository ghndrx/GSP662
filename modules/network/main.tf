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
}

resource "google_compute_backend_service" "fancy_be_orders" {
  name = "fancy-be-orders"
  port_name = "orders"
  protocol = "HTTP"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  backend {
    group = google_compute_instance_group_manager.fancy_be_mig.self_link
  }

  health_checks = [
    google_compute_http_health_check.fancy_be_orders_hc.self_link
  ]
}

resource "google_compute_backend_service" "fancy_be_products" {
  name = "fancy-be-products"
  port_name = "products"
  protocol = "HTTP"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  backend {
    group = google_compute_instance_group_manager.fancy_be_mig.self_link
  }

  health_checks = [
    google_compute_http_health_check.fancy_be_products_hc.self_link
  ]
}

resource "google_compute_url_map" "fancy_map" {
  name = "fancy-map"
  default_service = google_compute_backend_service.fancy_fe_frontend.self_link
}

resource "google_compute_path_matcher" "fancy_path_matcher" {
  name = "orders"
  default_service = google_compute_backend_service.fancy_fe_frontend.self_link

  path_rule {
    paths = ["/api/orders"]
    service = google_compute_backend_service.fancy_be_orders.self_link
  }

  path_rule {
    paths = ["/api/products"]
    service = google_compute_backend_service.fancy_be_products.self_link
  }

  url_map = google_compute_url_map.fancy_map.self_link
}

resource "google_compute_target_http_proxy" "fancy_proxy" {
  name = "fancy-proxy"
  url_map = google_compute_url_map.fancy_map.self_link
}

resource "google_compute_global_forwarding_rule" "fancy_http_rule" {
  name = "fancy-http-rule"
  target = google_compute_target_http_proxy.fancy_proxy.self_link
  port_range = "80"
}




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
#Create HealthChecks

resource "google_compute_http_health_check" "fancy_fe_hc" {
  name = "fancy-fe-hc"
  port = "8080"
  request_path = "/"
  check_interval_sec = 30
  timeout_sec = 10
  healthy_threshold = 1
  unhealthy_threshold = 3
}

resource "google_compute_http_health_check" "fancy_be_hc" {
  name = "fancy-be-hc"
  port = "8081"
  request_path = "/api/orders"
  check_interval_sec = 30
  timeout_sec = 10
  healthy_threshold = 1
  unhealthy_threshold = 3
}


resource "google_compute_http_health_check" "fancy_fe_frontend_hc" {
  name = "fancy-fe-frontend-hc"
  request_path = "/"
  port = 8080
}

resource "google_compute_http_health_check" "fancy_be_orders_hc" {
  name = "fancy-be-orders-hc"
  request_path = "/api/orders"
  port = 8081
}

resource "google_compute_http_health_check" "fancy_be_products_hc" {
  name = "fancy-be-products-hc"
  request_path = "/api/products"
  port = 8082
}


