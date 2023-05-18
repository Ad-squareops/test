variable "environment" {
  description = "Enter the environment name"
  default     = ""
  type        = string
}
variable "name" {
  description = "Enter the name of firebase"
  default     = ""
  type        = string
}
variable "google_project_id" {
  default     = ""
  type        = string
  description = "The name of GCP project"
}

variable "region" {
  default     = ""
  type        = string
  description = "The region to host the firebase"
}
variable "service_account" {
  default     = ""
  type        = string
  description = "The service_account to host"
}