resource "google_compute_region_autoscaler" "fancy_fe_autoscaler" {
  name = "fancy-fe-autoscaler"
  target = google_compute_instance_group_manager.fancy_fe_mig.self_link
  cooldown_period_sec = 60
  load_balancing_utilization_target = 0.6
  max_replicas = 2

  depends_on = [
    module.instance-group.fancy_fe_mig
  ]
}

resource "google_compute_region_autoscaler" "fancy_be_autoscaler" {
  name = "fancy-be-autoscaler"
  target = google_compute_instance_group_manager.fancy_be_mig.self_link
  cooldown_period_sec = 60
  load_balancing_utilization_target = 0.6
  max_replicas = 2
  depends_on = [
    module.instance-group.fancy_be_mig
  ]
}
