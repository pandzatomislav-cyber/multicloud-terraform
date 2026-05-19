terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# ── Azure Provider ────────────────────────────────────────────────────────────
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

# ── GCP Provider ──────────────────────────────────────────────────────────────
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# ── Azure Module ──────────────────────────────────────────────────────────────
module "azure" {
  source = "./modules/azure"

  resource_group_name  = var.azure_resource_group
  location             = var.azure_location
  storage_account_name = var.azure_storage_account_name
  environment          = var.environment
}

# ── GCP Module ────────────────────────────────────────────────────────────────
module "gcp" {
  source = "./modules/gcp"

  project_id        = var.gcp_project_id
  region            = var.gcp_region
  bucket_name       = var.gcp_bucket_name
  bigquery_dataset  = var.gcp_bigquery_dataset
  environment       = var.environment
}
