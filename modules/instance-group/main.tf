resource "google_compute_target_pool" "fancy_target_pool_fe" {
  name = "fancy-target-pool"

  instances = [
    google_compute_instance.fancy_fe_instance1.self_link,
    google_compute_instance.fancy_fe_instance2.self_link,
  ]

  health_checks = [
    google_compute_http_health_check.fancy_fe_hc.self_link,
  ]

  session_affinity = "CLIENT_IP"
}
resource "google_compute_target_pool" "fancy_target_pool_be" {
  name = "fancy-target-pool"

  instances = [
    google_compute_instance.fancy_be_instance1.self_link,
    google_compute_instance.fancy_be_instance2.self_link,
  ]

  health_checks = [
    google_compute_http_health_check.fancy_be_hc.self_link,
  ]

  session_affinity = "CLIENT_IP"
}


resource "google_compute_instance_group_manager" "fancy_fe_mig" {
  name = "fancy-fe-mig"
  base_instance_name = "fancy-fe"
  instance_template = google_compute_instance_template.fancy_fe_template.self_link
  target_size = 2
  
  target_pools = [
    google_compute_target_pool.fancy_target_pool_fe.self_link
  ]
  
  zone = "us-central1-f"
  
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
    google_compute_backend_service.fancy_backend_service,
    google_compute_target_pool.fancy_target_pool_fe,
  ]
}

resource "google_compute_instance_group_manager" "fancy_be_mig" {
  name = "fancy-be-mig"
  base_instance_name = "fancy-be"
  instance_template = google_compute_instance_template.fancy_be_template.self_link
  target_size = 2
  
  target_pools = [
    google_compute_target_pool.fancy_target_pool_be.self_link
  ]
  
  zone = "us-central1-f"
  
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
    google_compute_backend_service.fancy_backend_service,
    google_compute_target_pool.fancy_target_pool_be,
  ]
}



resource "google_compute_region_autoscaler" "fancy_fe_autoscaler" {
  name = "fancy-fe-autoscaler"
  target = google_compute_instance_group_manager.fancy_fe_mig.self_link
  cooldown_period_sec = 60
  load_balancing_utilization_target = 0.6
  max_replicas = 2

  depends_on = [
    module.google_compute_instance_group_manager.fancy_fe_mig
  ]
}

resource "google_compute_region_autoscaler" "fancy_be_autoscaler" {
  name = "fancy-be-autoscaler"
  target = google_compute_instance_group_manager.fancy_be_mig.self_link
  cooldown_period_sec = 60
  load_balancing_utilization_target = 0.6
  max_replicas = 2
  depends_on = [
    google_compute_instance_group_manager.fancy_be_mig
  ]
}
