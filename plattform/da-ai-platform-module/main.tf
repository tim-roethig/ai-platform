terraform {
  required_version = ">= 1.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0.0"
    }
  }
}

# module "storage_platform" {
#   source = "../storage-platform-module"

#   project_id = var.project_id
#   region     = var.region
#   zone       = var.zone
# }

module "container_plattform" {
  source = "../container-platform-module"

  project_id = var.project_id
  region     = var.region
}
