resource "google_sql_database_instance" "default" {
  name             = "nextjs-db-instance"
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled       = false
    }
  }
}

resource "google_sql_database" "nextjs_db" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "nextjs_user" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/nextjs-app"  # Docker イメージの場所
        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.default.connection_name
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
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