resource "google_project_service" "servicenetworking" {
  project = var.google_project_id
  service = "servicenetworking.googleapis.com"
}

resource "google_compute_global_address" "private_ip_alloc" {
  depends_on    = [google_project_service.servicenetworking]
  name          = format("%s-%s-mysql-private-ip", var.name, var.environment)
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_id
  project       = var.google_project_id
}

resource "google_service_networking_connection" "sql_private_connect" {
  depends_on              = [google_compute_global_address.private_ip_alloc]
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

module "sql-db_mysql" {
  depends_on          = [google_service_networking_connection.sql_private_connect]
  source              = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version             = "14.0.0"
  project_id          = var.google_project_id
  name                = format("%s-%s-sql", var.name, var.environment)
  region              = var.region
  zone                = var.zones
  database_version    = var.database_version
  tier                = var.tier
  deletion_protection = var.deletion_protection
  db_name             = var.db_name
  disk_size           = var.disk_size
  disk_autoresize     = var.disk_autoresize
  database_flags      = var.database_flags
  availability_type   = var.availability_type

  enable_default_db   = var.enable_default_db
  enable_default_user = var.enable_default_user
  ip_configuration = {
    authorized_networks = var.authorized_networks,
    ipv4_enabled        = var.ipv4_enabled,
    private_network     = var.private_network,
    require_ssl         = var.require_ssl,
    allocated_ip_range  = null
  }

  encryption_key_name = var.encryption_key_name
  user_name           = var.user_name
  user_password       = var.user_password
  user_host           = var.user_host
  user_labels         = var.user_labels
}