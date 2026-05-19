output "bucket_url" {
  description = "GCS bucket URL"
  value       = "gs://${google_storage_bucket.main.name}"
}

output "bigquery_dataset_id" {
  description = "BigQuery dataset ID"
  value       = google_bigquery_dataset.main.dataset_id
}

output "bigquery_table_id" {
  description = "BigQuery transactions table ID"
  value       = google_bigquery_table.transactions.table_id
}
