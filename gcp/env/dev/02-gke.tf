module "gke" {
  source = "../../modules/gke"
  #   additional_tags    = local.additional_tags
  environment              = local.environment
  name                     = local.name
  region                   = local.region
  vpc_name                 = module.vpc._02_vpc_name
  zones                    = ["europe-west1-b", "europe-west1-c"]
  google_project_id        = google_project.boundless_project.project_id
  registry_project_ids     = ["boundless-deploy"]
  subnet                   = module.vpc._05_private_subnet
  release_channel          = "STABLE"
  kubernetes_version       = "1.24"
  enable_private_endpoint  = false
  enable_private_nodes     = true
  remove_default_node_pool = "true"
  # master_authorized_networks = ""
  infra_np_instance_type      = "e2-medium"
  infra_np_locations          = "europe-west1-b,europe-west1-c"
  infra_np_min_count          = "1"
  infra_np_max_count          = "2"
  infra_np_disk_size_gb       = "30"
  infra_np_preemptive         = false
  infra_np_initial_node_count = "1"

}