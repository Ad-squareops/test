resource "google_project_service" "firebase" {
  project = var.google_project_id
  service = "firebase.googleapis.com"
}

resource "google_project_service" "firebasestorage" {
  depends_on = [google_project_service.firebase]
  project = var.google_project_id
  service = "firebasestorage.googleapis.com"
}

resource "google_storage_bucket" "storage_bucket" {
  depends_on = [google_project_service.firebasestorage]
  provider                    = google-beta
  name                        = format("%s-%s-bucket", var.name, var.environment)
  location                    = var.region
  project = var.google_project_id
  uniform_bucket_level_access = true
}

resource "google_service_account_key" "key_for_firebase_access" {
  depends_on = [google_storage_bucket.storage_bucket]
  service_account_id = var.service_account
}

resource "kubernetes_secret" "gcp_service_account_creds" {
  depends_on = [google_service_account_key.key_for_firebase_access]
  metadata {
    name = "gcp-creds"
  }
  data = {
    "cloud-service-key.json" = base64decode(google_service_account_key.key_for_firebase_access.private_key)
  }
}


resource "google_firebase_project" "firebase_project" {
    depends_on = [google_storage_bucket.storage_bucket]
    provider = google-beta
    project  = var.google_project_id
}

resource "google_firebase_storage_bucket" "firebase_storage_bucket" {
  depends_on = [google_firebase_storage_bucket.firebase_storage_bucket]
  provider  = google-beta
  project   = var.google_project_id
  bucket_id = google_storage_bucket.storage_bucket.id
}

resource "google_project_service" "firebase_database_service" {
  provider = google-beta
  project  = google_firebase_project.firebase_project.project
  service  = "firebasedatabase.googleapis.com"
}

resource "google_firebase_database_instance" "firebase_database" {
  depends_on = [google_project_service.firebase_database_service]
  provider = google-beta
  project  = google_firebase_project.firebase_project.project
  region   = var.region
  instance_id = format("%s-default-rtdb", var.google_project_id)
  type     = "DEFAULT_DATABASE"
  desired_state   = "ACTIVE"
}


resource "google_firebase_web_app" "web_app" {
    provider = google-beta
    project =var.google_project_id
    display_name = format("%s-%s-firebase-web-app", var.name, var.environment)
    deletion_policy = "DELETE"

    depends_on = [google_firebase_project.firebase_project]
}

data "google_firebase_web_app_config" "web_app_config" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.web_app.app_id
  project = google_firebase_project.firebase_project.id
}

resource "google_storage_bucket_object" "bucket_object" {
    provider = google-beta
    bucket = google_storage_bucket.storage_bucket.name
    name = "firebase-config.json"

    content = jsonencode({
        appId              = google_firebase_web_app.web_app.app_id
        apiKey             = data.google_firebase_web_app_config.web_app_config.api_key
        authDomain         = data.google_firebase_web_app_config.web_app_config.auth_domain
        databaseURL        = lookup(data.google_firebase_web_app_config.web_app_config, "database_url", "")
        storageBucket      = lookup(data.google_firebase_web_app_config.web_app_config, "storage_bucket", "")
        messagingSenderId  = lookup(data.google_firebase_web_app_config.web_app_config, "messaging_sender_id", "")
        measurementId      = lookup(data.google_firebase_web_app_config.web_app_config, "measurement_id", "")
    })
}