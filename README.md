# 🌍 Multi-Cloud Infrastructure as Code — Azure + GCP

Production-ready **Terraform** infrastructure provisioning resources across **Microsoft Azure** and **Google Cloud Platform** simultaneously. Modular architecture with environment support (dev / staging / prod).

---

## Infrastructure Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    Terraform Root Module                         │
│                       main.tf                                    │
└──────────────────┬──────────────────────┬───────────────────────┘
                   │                      │
         ┌─────────▼──────────┐  ┌────────▼───────────┐
         │   modules/azure    │  │    modules/gcp      │
         │                    │  │                     │
         │  Resource Group    │  │  GCS Bucket         │
         │  Storage Account   │  │  (versioned,        │
         │  3 Containers:     │  │   lifecycle rules)  │
         │   · raw            │  │                     │
         │   · processed      │  │  BigQuery Dataset   │
         │   · archive        │  │  BigQuery Table     │
         │                    │  │  (transactions)     │
         └────────────────────┘  └─────────────────────┘
```

---

## Resources Provisioned

### Azure
| Resource | Name | Purpose |
|---|---|---|
| Resource Group | `portfolio-rg` | Container for all Azure resources |
| Storage Account | configurable | Data lake storage with blob versioning |
| Container: raw | `raw` | Raw ingested data |
| Container: processed | `processed` | Transformed output data |
| Container: archive | `archive` | Long-term data retention |

### GCP
| Resource | Name | Purpose |
|---|---|---|
| GCS Bucket | configurable | Object storage with lifecycle management |
| BigQuery Dataset | `portfolio_analytics` | Analytics data warehouse |
| BigQuery Table | `transactions` | Typed schema for transaction data |

---

## Features

- **Modular design** — Azure and GCP split into reusable child modules
- **Environment support** — `dev`, `staging`, `prod` via a single variable
- **Input validation** — Terraform validates environment values at plan time
- **Security hardened** — TLS 1.2 enforced, private containers, uniform bucket access
- **Blob versioning** — enabled on both Azure and GCS for data recovery
- **GCS lifecycle rules** — auto-tier to Nearline (30d) and Coldline (90d) to minimise cost
- **GitHub Actions** — validates and formats Terraform on every push

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform >= 1.5 | Infrastructure as Code |
| Azure Provider ~> 3.100 | Azure resource management |
| Google Provider ~> 5.0 | GCP resource management |
| GitHub Actions | CI validation pipeline |

---

## Project Structure

```
multicloud-terraform/
├── main.tf                      # Root: providers + module calls
├── variables.tf                 # All input variable definitions
├── outputs.tf                   # Outputs from both clouds
├── terraform.tfvars.example     # Credential template
├── .github/
│   └── workflows/
│       └── terraform.yml        # Validate + fmt check on push
└── modules/
    ├── azure/
    │   ├── main.tf              # Azure resources
    │   ├── variables.tf
    │   └── outputs.tf
    └── gcp/
        ├── main.tf              # GCP resources
        ├── variables.tf
        └── outputs.tf
```

---

## Getting Started

### Prerequisites
- [Terraform >= 1.5](https://developer.hashicorp.com/terraform/install)
- Azure Service Principal with Contributor role
- GCP Service Account with Storage and BigQuery Admin roles

### Setup

```bash
# Clone the repo
git clone https://github.com/pandzatomislav-cyber/multicloud-terraform
cd multicloud-terraform

# Copy and fill in credentials
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

# Initialise providers
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply
```

### Destroy

```bash
terraform destroy
```

---

## GitHub Actions

On every push, the pipeline:
1. Checks Terraform formatting (`terraform fmt`)
2. Initialises providers (`terraform init -backend=false`)
3. Validates configuration (`terraform validate`)

No cloud credentials are required for validation — the workflow runs without applying any changes.

---

## Author

**Tomislav Pandza**
Dubai, UAE | [pandza.tomislav@gmail.com](mailto:pandza.tomislav@gmail.com) | [GitHub](https://github.com/pandzatomislav-cyber)

*Studying Microsoft Azure (AZ-900) and Google Cloud Associate Cloud Engineer certifications.*
