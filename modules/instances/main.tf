#BE Instance
resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "n1-standard-1"
  tags         = ["backend"]
  
    metadata = {
        startup-script-url = "gs://${var.fancy_store_name}/startup-script.sh"
    } 

  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }
}

#FE Instance
resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "n1-standard-1"
  tags         = ["frontend"]
  
  metadata = {
    startup-script-url = "gs://${var.fancy_store_name}/startup-script.sh"
  }
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }
}
