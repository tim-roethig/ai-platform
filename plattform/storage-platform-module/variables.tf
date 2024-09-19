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

variable "zone" {
  type        = string
  description = "Zone in region in which all resources will live."
  nullable    = false
}

variable "postgres_settings" {
  type = object({
    machine   = string
    disk_type = string
    disk_size = number
  })
  description = "Postgres DB Server settings."
  default = {
    machine   = "db-f1-micro"
    disk_type = "PD_HDD"
    disk_size = 16
  }
  nullable = false
}