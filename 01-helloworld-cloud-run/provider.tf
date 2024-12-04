provider "google" {
  credentials = file("C:\\Users\\pisa0\\AppData\\Roaming\\gcloud\\application_default_credentials.json")  # サービスアカウントの認証ファイル
  project     = var.project_id
  region      = var.region
}