output "azure_storage_account_name" {
  description = "Azure Storage Account name"
  value       = module.azure.storage_account_name
}

output "azure_storage_primary_endpoint" {
  description = "Azure Blob Storage primary endpoint"
  value       = module.azure.storage_primary_endpoint
}

output "gcp_bucket_url" {
  description = "GCS bucket URL"
  value       = module.gcp.bucket_url
}

output "gcp_bigquery_dataset_id" {
  description = "BigQuery dataset ID"
  value       = module.gcp.bigquery_dataset_id
}
