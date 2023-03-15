terraform {
  required_version = ">= 0.14.0"
}

variable "project_id" {
  description = "The ID of the GCP project."
}

variable "region" {
  description = "The region to create resources in."
  default = "us-central1"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./modules/network"
}

module "backend" {
  source = "./modules/backend"
  startup_script = module.network.startup_script
}

module "nat_gateway" {
  source = "./modules/network/nat_gateway"
  network_name = module.network.network_name
  region = var.region
}

module "firewall" {
  source = "./modules/firewall"
  network_name = module.network.network_name
}

module "frontend" {
  source = "./modules/frontend"
  backend_service_name = module.backend.backend_service_name
  network_name = module.network.network_name
}

output "frontend_external_ip" {
  value = module.frontend.external_ip
}
