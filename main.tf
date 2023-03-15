# Module Configuration

module "storage" {
  source = "./modules/storage"
  project_id = var.project_id
  
}

module "instance" {
  source = "./modules/instances"
  fancy_store_name = module.storage.fancy_store_name
}

module "healthchecks" {
  source = "./modules/network/healthchecks"
}

module "firewall" {
  source = "./modules/network/firewall"
  
}

module "loadbalancer" {
  source = "./modules/network/loadbalancer"
}

module "network" {
  source = "./modules/network"

}

module "instance-group" {
  source = "./modules/instance-group"
}

