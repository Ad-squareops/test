locals {
  region = var.region
  google_project_id = var.google_project_id
  environment    = var.environment
  name   = var.name
  subnet_01 = format("%s-%s-public-subnet", local.name, local.environment)
  subnet_02 = var.enable_nat_gateway ? format("%s-%s-private-subnet", local.name, local.environment) : format("%s-%s-public-subnet-2", local.name, local.environment)
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0"

  project_id   = local.google_project_id
  network_name = format("%s-%s-vpc", local.name, local.environment)
  routing_mode = "GLOBAL"
  subnets = [
    {
      subnet_name      = local.subnet_01
      subnet_ip        = var.public_subnet_cidr
      subnet_region    = local.region
      subnet_private_access = "false"
      subnet_flow_logs = var.flow_logs
    },
    {
      subnet_name           = local.subnet_02 
      subnet_ip             = var.private_subnet_cidr
      subnet_region         = local.region
      subnet_private_access = "true"
      subnet_flow_logs      = var.flow_logs
    }
  ]
  secondary_ranges = {
    "${local.subnet_02}" = [
            {
                range_name = format("%s-pods", local.subnet_02)
                ip_cidr_range = var.secondary_range_subnet_01
            },
            {   range_name = format("%s-services", local.subnet_02)
                ip_cidr_range = var.secondary_range_subnet_02
            },
            {   range_name = format("%s-mysql", local.subnet_02)
                ip_cidr_range = var.secondary_range_subnet_03
            }
        ]
}
}

# resource "google_project_service" "compute_googleapis_com" {
#   project = var.google_project_id
#   service = "compute.googleapis.com"
# }

# resource "google_compute_network" "vpc_network" {
#   depends_on = [google_project_service.compute_googleapis_com]
#   project                 = var.google_project_id
#   name                    = format("%s-%s-vpc", var.name, var.environment)
#   auto_create_subnetworks = false
# #   mtu                     = 1460
#   routing_mode = "REGIONAL"
# }

# resource "google_compute_subnetwork" "vpc_subnetwork" {
#   depends_on = [google_compute_network.vpc_network]
#   name          = format("%s-%s-subnetwork", var.name, var.environment)
#   ip_cidr_range = var.vpc_cidr
#   region        = var.region
#   network       = google_compute_network.vpc_network.id
#   project = var.google_project_id
# }

resource "google_compute_router" "router" {
  depends_on = [module.vpc]
  count      = var.enable_nat_gateway ? 1 : 0
  project    = local.google_project_id
  name       = format("%s-%s-router", local.name, local.environment)
  network    = module.vpc.network_name
  region     = local.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 2.2"
  count                              = var.enable_nat_gateway ? 1 : 0
  project_id                         = local.google_project_id
  region                             = local.region
  router                             = google_compute_router.router[0].name
  name                               = format("%s-%s-nat", local.name, local.environment)
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  subnetworks = [{
    name                     = local.subnet_02
    source_ip_ranges_to_nat  = ["ALL_IP_RANGES"]
    secondary_ip_range_names = []
  }]
}

