variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project to use for resources."
}

variable "region" {
  type        = string
  description = "The region to create resources in."
}

variable "sa_email" {
  type        = string
  description = "The email address of the service account to associate with the instance."
}

variable "image_name" {
  type        = string
  description = "The name of the image to use for the instance boot disk."
}
