# resource "google_cloud_run_v2_service" "mlflow" {
#   name                = "mlflow"
#   project             = var.project_id
#   location            = var.region
#   deletion_protection = false

#   template {
#     containers {
#       image   = "${var.region}-docker.pkg.dev/${var.project_id}/ghcr/mlflow/mlflow:v2.16.0"
#       command = ["mlflow"]
#       args    = ["ui", "--host=0.0.0.0"]
#       ports {
#         container_port = 5000
#       }
#       resources {
#         limits = {
#           cpu    = "1"
#           memory = "512Mi"
#         }
#       }
#     }
#   }
# }

# data "google_iam_policy" "noauth" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "allUsers",
#     ]
#   }
# }

# resource "google_cloud_run_service_iam_policy" "noauth" {
#   location = google_cloud_run_v2_service.mlflow.location
#   project  = google_cloud_run_v2_service.mlflow.project
#   service  = google_cloud_run_v2_service.mlflow.name

#   policy_data = data.google_iam_policy.noauth.policy_data
# }