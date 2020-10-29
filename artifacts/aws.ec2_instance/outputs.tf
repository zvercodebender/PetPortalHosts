# Output variable definitions

output "ec2_server_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.bdd.public_ip}"
}

output "ec2_server_private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.bdd.private_ip}"
}

output "ec2_server_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = "${aws_instance.bdd.public_dns}"
}

output "ec2_server_private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = "${aws_instance.bdd.private_dns}"
}

output "project" {
  value       = "${var.project}"
}
