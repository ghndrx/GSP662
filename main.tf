# Module Configuration


module "instances" {
  source = "./modules/instances"

}

module "instance-group" {
  source = "./modules/instance-group"
}


module "network" {
  source = "./modules/network"

}

module "storage" {
  source = "./modules/storage"
}

module "autoscale" {
  source = "./modules/autoscale"
}

module "firewall" {
  source = "./modules/network/firewall"
}

module "healthchecks" {
  source = "./modules/network/healthchecks"  
}

module "loadbalancer" {
  source = "./modules/network/loadbalancer"
}