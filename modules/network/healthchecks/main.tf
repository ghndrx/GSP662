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