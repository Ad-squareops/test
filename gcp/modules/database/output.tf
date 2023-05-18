output "_01_instance_name" {
  value       = module.sql-db_mysql.instance_name
  description = "The instance name for the master instance"
}
output "_02_Private_ip" {
  description = "Private IP"
  value       = module.sql-db_mysql.private_ip_address
}
output "_03_public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
  value       = module.sql-db_mysql.public_ip_address
}
output "_04_DB_instance_username" {
  description = "The master username for the database"
  value       = var.user_name
}
output "_05_DB_instance_password" {
  description = "The auto generated default user password if not input password was provided"
  value       = nonsensitive(module.sql-db_mysql.generated_user_password)
}
// Resources

 output "_06_addition_user" {
   description = "List of maps of additional users and passwords"
   value = [for r in (var.additional_users) :
     {
       name     = r.name
       password = r.password
     }
   ] 
   sensitive    = true
 }
// Replicas
output "_07_replicas_instance_first_ip_addresses" {
  value       = [for r in module.sql-db_mysql.replicas : r.ip_address]
  description = "The first IPv4 addresses of the addresses assigned for the replica instances"
}

output "_08_replicas_instance_connection_names" {
  value       = [for r in module.sql-db_mysql.replicas : r.connection_name]
  description = "The connection names of the replica instances to be used in connection strings"
}

output "_09_replicas_instance_self_links" {
  value       = [for r in module.sql-db_mysql.replicas : r.self_link]
  description = "The URIs of the replica instances"
}
output "_10_read_replica_instance_names" {
  value       = [for r in module.sql-db_mysql.replicas : r.name]
  description = "The instance names for the read replica instances"
}
 // Resources
 output "_11_primary" {
  value       = module.sql-db_mysql.primary
  description = "The `google_sql_database_instance` resource representing the primary instance"
  sensitive   = true
}
output "_12_replicas" {
  value       = module.sql-db_mysql.replicas
  description = "A list of `google_sql_database_instance` resources representing the replicas"
  sensitive   = true
}
output "_13_instances" {
  value       = module.sql-db_mysql.instances
  description = "A list of all `google_sql_database_instance` resources we've created"
  sensitive   = true
}

output "mysql" {
  description = "mysql_Info"
  value = {
    username         = var.user_name ,
    password         = var.user_password ,
    primary_url      = module.sql-db_mysql.private_ip_address
  }
}
