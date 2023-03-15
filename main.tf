# Module Configuration

module "storage" {
  source = "./modules/storage"
  project_id = var.project_id
  
}

output "fancy_store_name" {
  value = module.storage.fancy_store_name
}

module "instance" {
  source = "./modules/instances"

}