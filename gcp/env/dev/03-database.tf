module "database" {
  source              = "../../modules/database"
  environment         = local.environment
  name                = local.name
  region              = local.region
  network_id          = module.vpc._03_vpc_id
  zones               = "europe-west1-c"
  google_project_id   = google_project.boundless_project.project_id
  database_version    = "MYSQL_5_7"
  tier                = "db-g1-small"
  deletion_protection = true
  disk_size           = 20
  disk_autoresize     = false
  availability_type   = "ZONAL"
  enable_default_db   = true
  enable_default_user = true
  ipv4_enabled        = true
  private_network     = module.vpc._07_vpc_selflink
  require_ssl         = false
  db_name             = "boundless"
  user_name           = "boundless-test"
  user_password       = "boundless_pass"
  user_host           = "%"

}