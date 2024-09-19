variable "project_id" {
  type        = string
  description = "GCP wide unique project ID for project in which all resources will live."
  nullable    = false
}

variable "region" {
  type        = string
  description = "Region in which all resources will live."
  nullable    = false
}

