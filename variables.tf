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
