
resource "google_compute_instance_group_manager" "fancy_fe_mig" {
  name = "fancy-fe-mig"
  base_instance_name = "fancy-fe"
  instance_template = google_compute_instance_template.fancy_fe_template.self_link
  target_size = 2
  
  target_pools = [
    google_compute_target_pool.fancy_target_pool.self_link
  ]
  
  zone = "us-central1-a"
  
  update_policy {
    type = "PROACTIVE"
    min_instance_restart_time_sec = 300
  }
  
  named_port {
    name = "frontend"
    port = "8080"
  }
  
  depends_on = [
    google_compute_http_health_check.fancy_fe_hc,
    google_compute_backend_service.fancy_frontend_service
  ]
}

resource "google_compute_instance_group_manager" "fancy_be_mig" {
  name = "fancy-be-mig"
  base_instance_name = "fancy-be"
  instance_template = google_compute_instance_template.fancy_be_template.self_link
  target_size = 2
  
  target_pools = [
    google_compute_target_pool.fancy_target_pool.self_link
  ]
  
  zone = "us-central1-a"
  
  update_policy {
    type = "PROACTIVE"
    min_instance_restart_time_sec = 300
  }
  
  named_port {
    name = "orders"
    port = "8081"
  }
  
  named_port {
    name = "products"
    port = "8082"
  }
  
  depends_on = [
    google_compute_http_health_check.fancy_be_hc,
    google_compute_backend_service.fancy_backend_service
  ]
}
