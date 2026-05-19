# ── Shared ────────────────────────────────────────────────────────────────────
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# ── Azure ─────────────────────────────────────────────────────────────────────
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "azure_resource_group" {
  description = "Azure Resource Group name"
  type        = string
  default     = "portfolio-rg"
}

variable "azure_location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "azure_storage_account_name" {
  description = "Azure Storage Account name (globally unique, lowercase)"
  type        = string
}

# ── GCP ───────────────────────────────────────────────────────────────────────
variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "gcp_bucket_name" {
  description = "GCS bucket name (globally unique)"
  type        = string
}

variable "gcp_bigquery_dataset" {
  description = "BigQuery dataset ID"
  type        = string
  default     = "portfolio_analytics"
}
