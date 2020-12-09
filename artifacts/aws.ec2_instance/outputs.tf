# Output variable definitions
#######################################################
#  Webserver Variables
output "webserver_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = module.webserver.public_ip
}

output "webserver_private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = module.webserver.private_ip
}

output "webserver_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = module.webserver.public_dns
}
output "webserver_private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = module.webserver.private_dns
}
#######################################################
#  Appserver Variables
output "appserver_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = module.appserver.public_ip
}

output "appserver_private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = module.appserver.private_ip
}

output "appserver_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = module.appserver.public_dns
}

output "appserver_private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = module.appserver.private_dns
}

#######################################################
#  MySQL Variables
output "db_endpoint" {
  description = "Public IP addresses of MySQL instances"
  value       = module.db.db_endpoint
}
output "db_address" {
  description = "Public IP addresses of MySQL instances"
  value       = module.db.db_address
}
output "db_port" {
  description = "Public IP addresses of MySQL instances"
  value       = module.db.db_port
}
output "DB_URL" {
  description = "JDBC URL"
  value = module.db.DB_URL
}
output "mysqlHostOption" {
  description = "mysql host option"
  value = module.db.mysqlHostOption
}
#######################################################

output "project" {
  value       = "${var.project}"
}
