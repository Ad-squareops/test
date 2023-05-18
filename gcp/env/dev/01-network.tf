locals {
  vpc_cidr                  = "10.0.0.0/12"
  public_subnet_cidr        = "10.1.0.0/16"
  private_subnet_cidr       = "10.2.0.0/16"
  secondary_range_subnet_01 = "10.3.0.0/16"
  secondary_range_subnet_02 = "10.4.0.0/16"
  secondary_range_subnet_03 = "10.5.0.0/16"

}

module "vpc" {
  source     = "../../modules/network"
  depends_on = [google_project.boundless_project]
  #   additional_tags    = local.additional_tags
  environment                        = local.environment
  name                               = local.name
  region                             = local.region
  vpc_cidr                           = local.vpc_cidr
  google_project_id                  = local.google_project_id
  public_subnet_cidr                 = local.public_subnet_cidr
  private_subnet_cidr                = local.private_subnet_cidr
  secondary_range_subnet_01          = local.secondary_range_subnet_01
  secondary_range_subnet_02          = local.secondary_range_subnet_02
  secondary_range_subnet_03          = local.secondary_range_subnet_03
  enable_nat_gateway                 = true
  flow_logs                          = true
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
}

