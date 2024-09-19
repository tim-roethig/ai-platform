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
  project_id = "test-evbf6v06"
}

resource "google_project" "main-project" {
  name            = "main-project"
  project_id      = local.project_id
  billing_account = "01DA77-56895F-DCBAB0"
  deletion_policy = "PREVENT"
}

import {
  to = google_project.main-project
  id = local.project_id
}

module "da-ai-platfrom" {
  source = "./da-ai-platform-module"

  project_id = local.project_id
  region     = "us-east5"
  zone       = "us-east5-a"
}
