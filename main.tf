terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = var.region
  network    = var.network
  subnet     = var.subnet
}

module "backend" {
  source = "./modules/backend"
}

module "frontend" {
  source        = "./modules/frontend"
  project_id    = var.project_id
  region        = var.region
  instance_type = var.instance_type
  backend_ip    = module.network.backend_ip
  subnet_ip     = module.network.subnet_ip
}
