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
