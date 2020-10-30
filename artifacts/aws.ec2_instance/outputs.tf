# Output variable definitions
#######################################################
#  MySQL Variables
output "webserver_public_ip" {
  description = "Public IP addresses of MySQL instances"
  value       = "${aws_db_instance.mysqldb.address}"
}
