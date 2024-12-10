
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-northeast1"
}

variable "iap_user_email" {
  description = "Email address to grant access to IAP"
  type        = string
}

variable "cloud_run_image" {
  description = "Cloud Run Docker image"
  type        = string
  default     = "gcr.io/cloudrun/hello" # サンプル用コンテナイメージ
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "hello-world-iap"
}

variable "load_balancer_name" {
  description = "Google Cloud Load Balancer name"
  type =string
  default = "iap-load-balancer-ip"
}

variable "url_map_name" {
  description = "Google URL Map name"
  type = string
  default = "iap-url-map"
}

variable "proxy_name" {
  description = "Google proxy name"
  type = string
  default = "iap-http-proxy"
}

variable "neg_name" {
  description = "network endpoint group name"
  type = string
  default = "cloudrun-neg"
}

variable "domain_name" {
  type = string
}