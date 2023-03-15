# Module Configuration

module "storage" {
  source = "./modules/storage"
  project_id = var.project_id
  
}

module "instance" {
  source = "./modules/instances"
  fancy_store_name = module.storage.fancy_store_name
}

module "network" {
  source = "./modules/network"

}


