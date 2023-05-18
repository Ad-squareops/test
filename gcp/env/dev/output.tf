output "private_subnet_selflink" {
  description = "The URI of the VPC being created"
  value       = module.vpc._08_private_subnet_selflink
}
output "rabbitmq" {
  description = "Rabbitmq_Info"
  value = module.gke-bootstrap.rabbitmq
}
output "mysql" {
  description = "Mysql_Info"
  value = module.database.mysql
}