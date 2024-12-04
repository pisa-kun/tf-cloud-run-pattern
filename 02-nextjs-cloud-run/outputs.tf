output "url" {
  value = google_cloud_run_service.default.status[0].url
  description = "URL of the Cloud Run service"
}
