variable "environment" {
  default = ""
  type    = string
}
variable "name" {
  default = "resouce names prefix"
  type = string
}
variable "ingress_nginx_enabled" {
  type    = bool
  default = false
}
variable "ingress_nginx_version" {
  default = ""
  type    = string
}
variable "cert_manager_version" {
  default = ""
  type    = string
}
variable "cert_manager_enabled" {
  type    = bool
  default = false
}
variable "rabbitmq_enabled" {
  default = false
  type    = bool
}
variable "rabbitmq_hostname" {
  default = ""
  type    = string
}
