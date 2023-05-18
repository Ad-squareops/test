variable "google_project_id" {
  description = "Google project id"
  default     = ""
  type        = string 
}
variable "environment" {
  description = "Enter the environment name"
  default     = ""
  type        = string
}
variable "name" {
  description = "Enter the name of vpc"
  default     = ""
  type        = string
}
variable "region" {
  description = "Enter the region"
  default     = ""
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR range of vpc"
  default     = ""
  type        = string
}
variable "enable_nat_gateway" {
  description = "Create natgateway"
  default     = false
  type        = bool
}

variable "public_subnet_cidr" {
  description = "The IP and CIDR range of the subnet being created"
  default     = ""
  type        = string
}

variable "private_subnet_cidr" {
  description = "The IP and CIDR range of the subnet being created"
  default     = ""
  type        = string
}
variable "flow_logs" {
  description = "Whether the subnet will record and send flow log data to logging"
  default     = false
  type        = bool
}

variable "secondary_range_subnet_01" {
  default     = []
  type        = any
}

variable "secondary_range_subnet_02" {
  default     = []
  type        = any
}
variable "secondary_range_subnet_03" {
  default     = []
  type        = any
}
variable "source_subnetwork_ip_ranges_to_nat" {
  description = "(Optional) Defaults to ALL_SUBNETWORKS_ALL_IP_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS. Changing this forces a new NAT to be created."
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
# variable "log_config_enable_nat" {
#   default     = false
#   type        = bool
#   description = "Indicates whether or not to export logs"
# }
# variable "log_config_filter_nat" {
#   default     = "ALL"
#   description = "Specifies the desired filtering of logs on this NAT. Valid values are: \"ERRORS_ONLY\", \"TRANSLATIONS_ONLY\", \"ALL\""
#   type        = string
# }

