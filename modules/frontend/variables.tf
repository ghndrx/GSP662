variable "project_id" {
  description = "The ID of the Google Cloud project where resources will be created"
}

variable "region" {
  description = "The region in which to create the resources"
}

variable "zone" {
  description = "The zone in which to create the resources"
}

variable "instance_name" {
  description = "The name to assign to the Compute Engine instance"
}

variable "machine_type" {
  description = "The machine type of the Compute Engine instance"
  default     = "f1-micro"
}

variable "image_name" {
  description = "The name of the image to use for the Compute Engine instance boot disk"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "network_name" {
  description = "The name of the network to which the Compute Engine instance will be attached"
}

variable "startup_script_path" {
  description = "The local path to the startup script to be run on the Compute Engine instance"
}
