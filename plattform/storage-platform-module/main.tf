terraform {
  required_version = ">= 1.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0.0"
    }
  }
}

locals {
  apis = [
    "sql-component.googleapis.com",
    "storage-component.googleapis.com"
  ]
}

resource "google_project_service" "storage_service" {
  for_each                   = toset(local.apis)
  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_storage_bucket" "object_store" {
  depends_on = [google_project_service.storage_service]

  name          = "object-store-${var.project_id}"
  location      = var.region
  force_destroy = true
}

resource "google_sql_database_instance" "db" {
  depends_on = [google_project_service.storage_service]

  name                = "db"
  project             = var.project_id
  database_version    = "POSTGRES_15"
  region              = var.region
  deletion_protection = false

  settings {
    tier            = var.postgres_settings.machine
    disk_type       = var.postgres_settings.disk_type
    disk_size       = var.postgres_settings.disk_size
    disk_autoresize = false
    location_preference {
      zone = var.zone
    }
  }
}