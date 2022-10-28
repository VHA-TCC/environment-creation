terraform {
  required_providers {
    google = ">= 3.31.0"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("${var.google_credential_path}")
}
