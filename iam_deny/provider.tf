terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.62.1"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.62.1"
    }
  }
}

provider "google-beta" {}
provider "google" {
  # Configuration options
  #  project = var.project_id
  # folder_id = var.folder_id
  region = var.region
  zone   = var.zone
}