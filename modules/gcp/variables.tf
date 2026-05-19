variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "bucket_name" {
  description = "GCS bucket name"
  type        = string
}

variable "bigquery_dataset" {
  description = "BigQuery dataset ID"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}
