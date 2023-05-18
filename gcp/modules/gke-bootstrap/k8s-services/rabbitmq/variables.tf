variable "rabbitmq_enabled" {
  default = false
  type    = bool
}

variable "rabbitmq_hostname" {
  default = ""
  type    = string
}

variable "namespace" {
  default = "rabbitmq"
  type    = string
}
