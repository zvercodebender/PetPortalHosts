##########################################################################
#
# variables
variable "my-sg" {
  type = list(string)
}
variable "my-ami" {
  type = string
}
variable "ssh-key" {
  type    = string
}
variable "ami-size" {
  type         = string
}
##########################################################################
#  Appserver
#
resource "aws_instance" "appserver" {
  ami                    = var.my-ami
  instance_type          = var.ami-size
  key_name               = var.ssh-key 
  vpc_security_group_ids = var.my-sg

  associate_public_ip_address = true
    tags = {
      Name = "rrb-appserver"
      Terraform   = "true"
      Environment = "dev"
    }

#  user_data     = <<-EOF
#                  #!/bin/bash
#                  sudo yum -y install mariadb java mysql-connector-java
#                  #sudo systemctl enable tomcat
#                  #sudo systemctl start tomcat
#                  EOF

  provisioner "file" {
    source      = "${path.module}/appserver_install.sh"
    destination = "~/appserver_install.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/rick/.ssh/rbroker-us1.pem")
      host        = self.public_dns
    }
  }
  provisioner "remote-exec" {
    inline = [
         "mkdir /home/ec2-user/resources"
         ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/rbroker-us1.pem")
      host        = self.public_dns
    }
  }
  provisioner "file" {
    source      = "${path.module}/resources/install-mysql-driver.sh"
    destination = "~/resources/install-mysql-driver.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/rick/.ssh/rbroker-us1.pem")
      host        = self.public_dns
    }
  }
  provisioner "file" {
    source      = "${path.module}/resources/mgmt-users.properties"
    destination = "~/resources/mgmt-users.properties"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/rick/.ssh/rbroker-us1.pem")
      host        = self.public_dns
    }
  }
  provisioner "remote-exec" {
    inline = [
         "chmod +x /home/ec2-user/appserver_install.sh",
         "chmod +x /home/ec2-user/resources/*",
         "/home/ec2-user/appserver_install.sh"
         ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/rbroker-us1.pem")
      host        = self.public_dns
    }
  }
}
#######################################################
#  Appserver Variables
output "public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.appserver.public_ip
}

output "private_ip" {
  description = "Private IP addresses of EC2 instances"
  value       = aws_instance.appserver.private_ip
}

output "public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.appserver.public_dns
}

output "private_dns" {
  description = "Private IP addresses of EC2 instances"
  value       = aws_instance.appserver.private_dns
}
