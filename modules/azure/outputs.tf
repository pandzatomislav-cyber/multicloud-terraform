output "storage_account_name" {
  description = "Azure Storage Account name"
  value       = azurerm_storage_account.main.name
}

output "storage_primary_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.main.name
}
