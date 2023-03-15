variable "project_id" {
  type        = string
  description = "The ID of the project to deploy resources into"
}

variable "region" {
  type        = string
  description = "The region to deploy resources into"
  default = "us-central1"
}


variable "zone" {
  type        = string
  description = "The zone in which resource to be deployed"
  default = "us-central1-f"
}