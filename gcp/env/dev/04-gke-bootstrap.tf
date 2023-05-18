data "google_client_config" "provider" {}

data "google_container_cluster" "gke_cluster" {
  name     = module.gke.cluster_name
  location = module.gke.region
  project  = google_project.boundless_project.project_id
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.gke_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.gke_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,
    )
  }
}


module "gke-bootstrap" {
  source     = "../../modules/gke-bootstrap"
  depends_on = [module.gke]

  name                  = local.name
  environment           = local.environment
  ingress_nginx_enabled = true
  ingress_nginx_version = "4.5.2"
  cert_manager_enabled   = true
  cert_manager_version   = "1.9.0"
  rabbitmq_enabled      = true
  rabbitmq_hostname     = "rabbitmq.tf01.boundless.com"
}