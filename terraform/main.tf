resource "google_project" "ironstone" {
  name = "ironstone"
  project_id = "ironstone-397814"
  billing_account = "018A3C-FE8F67-1C5B61"
  labels = {
    "firebase" = "enabled"
  }
}

resource "google_storage_bucket" "terraform-state-bucket" {
  name = "${google_project.ironstone.project_id}-terraform-state"
  force_destroy = false
  location = "EU"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_project_service" "default" {
  provider = google-beta.no_user_project_override
  project = google_project.ironstone.project_id
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    # Enabling the ServiceUsage API allows the new project to be quota checked from now on.
    "serviceusage.googleapis.com",
  ])
  service = each.key
  disable_on_destroy = false
}

resource "google_firebase_project" "ironstone" {
  provider = google-beta
  project = google_project.ironstone.project_id

  depends_on = [
    google_project_service.default
  ]
}