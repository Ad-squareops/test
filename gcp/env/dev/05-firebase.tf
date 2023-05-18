module "firebase" {
  source              = "../../modules/firebase"
  depends_on          = [module.gke]
  environment         = local.environment
  name                = local.name
  region              = local.region
  google_project_id   = google_project.boundless_project.project_id
  service_account     = module.gke.service_account
}