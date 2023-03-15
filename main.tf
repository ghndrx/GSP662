# Module Configuration

module "storage" {
  source = "./modules/storage"
  project_id = var.project_id
  
}

module "instance" {
  source = "./modules/instances"

}