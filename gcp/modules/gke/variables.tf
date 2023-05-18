variable "environment" {
  description = "Enter the environment name"
  default     = ""
  type        = string
}
variable "name" {
  description = "Enter the name of gke cluster"
  default     = ""
  type        = string
}
variable "google_project_id" {
  default     = ""
  type        = string
  description = "The name of GCP project"
}
variable "registry_project_ids" {
  default     = []
  type        = list(string)
  description = "The name of GCP project"
}
variable "region" {
  default     = ""
  type        = string
  description = "The region to host the gke cluster"
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

variable "source_image" {
  description = "The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}}"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "tags" {
  default     = ""
  type        = string
  description = "Tags for naming convention"
}

variable "master_authorized_networks" {
  default     = ""
  type        = string
  description = "Master authorized network for cluster"
}
variable "master_vpc_cidr" {
  default     = "10.0.0.0/28"
  type        = string
  description = "CIDR of master VPC"
}
variable "master_ipv4_cidr_block" {
  default     = ""
  type        = string
  description = "CIDR of master ipv4 block"
}
variable "network_policy" {
  default     = false
  type        = bool
  description = "Create network policy"
}
variable "network_name" {
  default     = ""
  type        = string
  description = "The name of network"
}
variable "public_subnet" {
  default     = ""
  type        = string
  description = "The name of public subnet"
}

variable "subnet" {
  default     = ""
  type        = string
  description = "The name of subnet"
}
variable "kubernetes_version" {
  type        = string
  description = "Pass kubernetes version"
  default     = null
}
variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
  default     = null
}
variable "remove_default_node_pool" {
  default     = true
  type        = bool
  description = "Remove default node pool"
}
variable "service_account" {
  default     = ""
  type        = string
  description = "The name of service account"
}
variable "service_acc_names" {
  type        = list(string)
  description = "Names of the service accounts to create"
  default     = []
}
variable "vpc_name" {
  default     = ""
  type        = string
  description = "The name of the vpc"
}
variable "enable_private_endpoint" {
  type        = bool
  default     = false
  description = "Create private cluster endpoint"
}
variable "enable_private_nodes" {
  default     = true
  type        = bool
  description = "Enable private nodes"
}

variable "infra_np_name" {
  default     = ""
  type        = string
  description = "The name of the infra node pool"
}


variable "infra_np_instance_type" {
  default     = ""
  type        = string
  description = "Instance type for infra nodes"
}

variable "infra_np_locations" {
  type        = string
  description = "The lpcation(zone) of infra nodes"
}

variable "infra_np_min_count" {
  default     = 1
  type        = number
  description = "Minimum number of infra nodes"
}

variable "infra_np_max_count" {
  default     = 5
  type        = number
  description = "Maximum number of infra nodes"
}

variable "infra_np_disk_size_gb" {
  default     = 20
  type        = number
  description = "Disk size of infra nodes"
}

variable "infra_np_initial_node_count" {
  default     = 1
  type        = number
  description = "Initial count for infra nodes"
}
variable "ip_range_pods_name" {
  default     = ""
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "infra_np_preemptive" {
  default     = true
  type        = bool
  description = "Create preemptive type infra nodes"
}
