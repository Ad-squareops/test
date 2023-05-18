resource "google_project_service" "container_googleapis_com" {
  project = var.google_project_id
  service = "container.googleapis.com"
}

module "gke" {
  depends_on = [google_project_service.container_googleapis_com]
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.google_project_id
  registry_project_ids       = var.registry_project_ids
  name                       = format("%s-%s-gke-cluster", var.name, var.environment)
  region                     = var.region
  zones                      = var.zones
  network                    = var.vpc_name
  subnetwork                 = var.subnet
  release_channel            = var.release_channel
  kubernetes_version         = var.kubernetes_version
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  enable_private_endpoint    = var.enable_private_endpoint
  enable_private_nodes       = var.enable_private_nodes
  # master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  create_service_account     = true
  grant_registry_access      = true
  remove_default_node_pool   = var.remove_default_node_pool
  master_authorized_networks = var.enable_private_endpoint ? [{ cidr_block = var.master_authorized_networks, display_name = "VPN IP" }] : []
  ip_range_pods              = format("%s-pods", var.subnet)
  ip_range_services          = format("%s-services", var.subnet)
  node_pools = [
    {
      name               = format("%s-%s-node-pool", var.name, var.environment)
      machine_type       = var.infra_np_instance_type
      node_locations     = var.infra_np_locations
      min_count          = var.infra_np_min_count
      max_count          = var.infra_np_max_count
      local_ssd_count    = 0
      disk_size_gb       = var.infra_np_disk_size_gb
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = var.infra_np_preemptive
      initial_node_count = var.infra_np_initial_node_count
    }
  ]


  node_pools_labels = {
    all = {}

    format("%s-%s-node-pool", var.infra_np_name, var.environment) = {
      "Infra-Services" = true
    }
  }

}


# resource "null_resource" "get_kubeconfig" {
#   depends_on = [module.gke]

#   provisioner "local-exec" {
#     command = "gcloud container clusters get-credentials ${module.gke.name} --region=${module.gke.region}"
#   }
# }