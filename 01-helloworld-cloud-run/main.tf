resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"  # Cloud Runで提供されているサンプルのDockerイメージを使用
        ports {
          container_port = 8080
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service = google_cloud_run_service.default.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}