variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy the Cloud Run service"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "nextjs-app"
}

variable "db_name" {
  description = "PostgreSQL database name"
  default     = "nextjs_db"
}

variable "db_user" {
  description = "PostgreSQL user"
  default     = "nextjs_user"
}

variable "db_password" {
  description = "PostgreSQL password"
  default     = "password"
}