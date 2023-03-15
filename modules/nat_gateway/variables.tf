# Variables for network module
variable "region" {
  description = "The region where the network will be created"
  type        = string
}

variable "project_id" {
  description = "The project id where the network will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet within the VPC network"
  type        = string
}

variable "subnet_ip_cidr_range" {
  description = "The IP CIDR range of the subnet within the VPC network"
  type        = string
}

# Variables for backend module
variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

# Variables for frontend module
variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "instance_zone" {
  description = "The zone where the instance will be created"
  type        = string
}

variable "machine_type" {
  description = "The machine type of the instance"
  type        = string
}

variable "instance_startup_script" {
  description = "The startup script for the instance"
  type        = string
}

variable "firewall_allow_80" {
  description = "Whether or not to allow incoming traffic on port 80"
  type        = bool
}

# Variables for nat_gateway module
variable "nat_gateway_name" {
  description = "The name of the NAT gateway instance"
  type        = string
}

variable "nat_gateway_zone" {
  description = "The zone where the NAT gateway instance will be created"
  type        = string
}

variable "nat_gateway_machine_type" {
  description = "The machine type of the NAT gateway instance"
  type        = string
}

variable "nat_gateway_startup_script" {
  description = "The startup script for the NAT gateway instance"
  type        = string
}

variable "nat_subnet_name" {
  description = "The name of the subnet in which to deploy the NAT gateway"
  type        = string
}

# Variables for firewall module
variable "allowed_ingress_ports" {
  description = "The list of ingress ports allowed to access the instance"
  type        = list(number)
  default     = [22, 80]
}

variable "allowed_egress_ports" {
  description = "The list of egress ports allowed to leave the instance"
  type        = list(number)
  default     = []
}
