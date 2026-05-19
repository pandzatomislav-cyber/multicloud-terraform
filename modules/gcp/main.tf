resource "google_storage_bucket" "main" {
  name          = var.bucket_name
  location      = upper(var.region)
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 90
    }
  }

  uniform_bucket_level_access = true

  labels = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "portfolio"
  }
}

resource "google_bigquery_dataset" "main" {
  dataset_id                  = var.bigquery_dataset
  friendly_name               = "Portfolio Analytics"
  description                 = "Analytics dataset provisioned by Terraform"
  location                    = upper(var.region)
  delete_contents_on_destroy  = false

  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "google_bigquery_table" "transactions" {
  dataset_id          = google_bigquery_dataset.main.dataset_id
  table_id            = "transactions"
  deletion_protection = false

  schema = jsonencode([
    { name = "transaction_id", type = "STRING",    mode = "REQUIRED" },
    { name = "timestamp",      type = "TIMESTAMP", mode = "REQUIRED" },
    { name = "store",          type = "STRING",    mode = "NULLABLE" },
    { name = "category",       type = "STRING",    mode = "NULLABLE" },
    { name = "product",        type = "STRING",    mode = "NULLABLE" },
    { name = "quantity",       type = "INTEGER",   mode = "NULLABLE" },
    { name = "unit_price",     type = "FLOAT",     mode = "NULLABLE" },
    { name = "total",          type = "FLOAT",     mode = "NULLABLE" },
    { name = "payment_method", type = "STRING",    mode = "NULLABLE" },
  ])

  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
