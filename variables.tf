variable "project_id" {
  type        = string
  description = "The ID of the project to deploy resources into"
}

variable "region" {
  type        = string
  description = "The region to deploy resources into"
}

variable "network_cidr" {
  type        = string
  description = "The CIDR block for the VPC network"
}


variable "network_name" {}

variable "subnet_name" {}

variable "firewall_name" {}

module "network" {
  source  = "./modules/network"
  project_id = var.project_id
  region = var.region
  network_name = var.network_name
  subnet_name = var.subnet_name
}

module "firewall" {
  source  = "./modules/firewall"
  project_id = var.project_id
  region = var.region
  network_name = module.network.network_name
  subnet_name = module.network.subnet_name
  firewall_name = var.firewall_name
}
