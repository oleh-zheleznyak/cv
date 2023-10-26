terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~>4.0"
    }
  }
}

provider "google-beta" {
  user_project_override = true
  project = "ironstone-397814"
}

provider "google-beta" {
  alias = "no_user_project_override"
  user_project_override = false
  project = "ironstone-397814"
}