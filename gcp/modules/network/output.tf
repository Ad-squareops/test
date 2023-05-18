output "_01_Region" {
  description = "VPC Region"
  value       = var.region
}

output "_02_vpc_name" {
  description = "VPC Name"
  value       = module.vpc.network_name
}
output "_03_vpc_id" {
  description = "VPC id"
  value       = module.vpc.network_id
}

output "_03_NAT_Gateway" {
  description = "Nat gateway"
  value       = var.enable_nat_gateway ? module.cloud-nat[0].name : null
}

output "_04_public_subnet" {
  description = "Public subnet"
  value       = format("%s-%s-public-subnet", var.name, var.environment)
}

output "_05_private_subnet" {
  description = "Private subnet"
  value       = var.enable_nat_gateway ? format("%s-%s-private-subnet", var.name, var.environment) : null
}
output "_06_public_subnet" {
  description = "Public subnet"
  value       = var.enable_nat_gateway ? null : format("%s-%s-public-subnet-2", var.name, var.environment)
}
output "_07_vpc_selflink" {
  description = "The URI of the VPC being created"
  value       = module.vpc.network_self_link
}
output "_08_private_subnet_selflink" {
  description = "The URI of the VPC being created"
  value       = module.vpc.subnets_self_links[0]
}