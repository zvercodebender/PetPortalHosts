# Output variable definitions
#######################################################
#  MySQL Variables
output "db_endpoint" {
  description = "Public IP addresses of MySQL instances"
  value       = "${aws_db_instance.mysqldb.endpoint}"
}
output "db_address" {
  description = "Public IP addresses of MySQL instances"
  value       = "${aws_db_instance.mysqldb.address}"
}
output "db_port" {
  description = "Public IP addresses of MySQL instances"
  value       = "${aws_db_instance.mysqldb.port}"
}
