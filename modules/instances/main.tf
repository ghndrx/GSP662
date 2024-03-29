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
  service_account {
    // Use the default service account
    email = "default"
    scopes = ["cloud-platform"]
  }
  network_interface {
    network = "default"
       access_config {
      // Assign a public (external) IP address to the instance
       
    }
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
  service_account {
    // Use the default service account
    email = "default"
    scopes = ["cloud-platform"]
  }
  network_interface {
    network = "default"
       access_config {
      // Assign a public (external) IP address to the instance
        
    }
  }
}
