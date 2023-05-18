output "rabbitmq" {
  description = "rabbitmq_Info"
  value = {
    username = var.rabbitmq_enabled ? "admin": null,
    password = var.rabbitmq_enabled ? module.rabbitmq[0].rabbitmq_password : null,
    url      = var.rabbitmq_enabled ? var.rabbitmq_hostname : null
  }
}