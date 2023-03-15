variable "project_id" {
  description = "The ID of the Google Cloud project to deploy resources to."
}

variable "region" {
  description = "The region where the resources will be created."
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the VPC network to be created."
  default     = "fancy-store-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet to be created."
  default     = "fancy-store-subnet"
}

variable "subnet_cidr_range" {
  description = "The CIDR range of the subnet to be created."
  default     = "10.0.0.0/24"
}
