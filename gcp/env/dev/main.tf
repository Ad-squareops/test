provider "google" {
  project = local.google_project
  region  = local.region
}
resource "google_project" "boundless_project" {
  name                = local.google_project
  project_id          = local.google_project_id
  org_id              = local.google_org_id
  skip_delete         = true
  billing_account     = "001B60-45ACA5-C5957D"
  auto_create_network = false
  labels = {
    "firebase" = "enabled"
  }
}
# terraform import google_project.boundless_project projects/boundless-test-tf-01

locals {
  name              = "boundless"
  environment       = "dev-test"
  region            = "europe-west1"
  google_project    = "boundless-test-tf"
  google_project_id = "boundless-test-tf-001"
  google_org_id     = "1065833544116"
  domain_name       = "boundless.com"
  additional_tags   = "terraform"
}

# resource "google_project_service" "cloudresourcemanager" {
#   depends_on = [google_project.boundless_project]
#   project = google_project.boundless_project.project_id
#   service = "cloudresourcemanager.googleapis.com"
# }
