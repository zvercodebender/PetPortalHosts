# Output variable definitions
#######################################################
#  Webserver Variables
output "webserver_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.webserver.public_ip}"
}

output "webserver_private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.webserver.private_ip}"
}

output "webserver_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.webserver.public_dns}"
}
output "webserver_private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.appserver.private_dns}"
}
#######################################################
#  Appserver Variables
output "appserver_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.appserver.public_ip}"
}

output "appserver_private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.appserver.private_ip}"
}

output "appserver_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.appserver.public_dns}"
}

output "appserver_private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.appserver.private_dns}"
}
output "project" {
  value       = "${var.project}"
}
