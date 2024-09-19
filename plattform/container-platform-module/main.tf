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
    "artifactregistry.googleapis.com",
    "container.googleapis.com",
    "run.googleapis.com",
  ]
}

resource "google_project_service" "container_service" {
  for_each                   = toset(local.apis)
  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_artifact_registry_repository" "registry" {
  depends_on = [google_project_service.container_service]

  project       = var.project_id
  location      = var.region
  repository_id = "registry"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_artifact_registry_repository" "ghcr_remote_repo" {
  depends_on = [google_project_service.container_service]

  project       = var.project_id
  location      = var.region
  repository_id = "ghcr"
  description   = "Remote repository for GitHub Container Registry"

  format = "DOCKER"
  mode   = "REMOTE_REPOSITORY"
  remote_repository_config {
    description = "GitHub Container Registry"
    docker_repository {
      custom_repository {
        uri = "https://ghcr.io"
      }
    }
  }
}

resource "google_container_cluster" "k8s-cluster" {
  depends_on = [google_project_service.container_service]

  name     = "k8s-cluster"
  project  = var.project_id
  location = var.region

  enable_autopilot    = true
  deletion_protection = false
}