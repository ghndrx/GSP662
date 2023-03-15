
# Module Configuration
module "backend" {
  source = "./modules/backend"

  instance_name   = var.backend_instance_name
  machine_type    = var.backend_machine_type
  zone            = var.zone
  network_name    = module.network.network_name
  subnet_name     = module.network.backend_subnet_name
  tags            = ["backend"]
  image_family    = "debian-11"
  image_project   = "debian-cloud"
}

module "frontend" {
  source = "./modules/frontend"

  instance_name   = var.frontend_instance_name
  machine_type    = var.frontend_machine_type
  zone            = var.zone
  network_name    = module.network.network_name
  subnet_name     = module.network.frontend_subnet_name
  tags            = ["frontend"]
}

module "network" {
  source = "./modules/network"

  project_id        = var.project_id
  region            = var.region
  network_name      = var.network_name
  subnet_cidrs      = var.subnet_cidrs
  nat_gateway_count = var.nat_gateway_count
  firewall_name     = var.firewall_name
}

module "firewall" {
  source = "./modules/firewall"

  project_id     = var.project_id
  network_name   = module.network.network_name
  firewall_name  = var.firewall_name
  allowed_ports  = var.allowed_ports
  target_tags    = ["backend"]
}
