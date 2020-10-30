# Terraform configuration

provider "aws" {
  region = "{{AWSRegion}}"
  access_key = "{{AWS_ACCESS_KEY}}"
  secret_key = "{{AWS_SECRET_KEY}}"
}

##########################################################################
#  Webserver
#
resource "aws_instance" "webserver" {
  ami                    = "ami-0e01ce4ee18447327"
  instance_type          = "t2.micro"
  key_name               = "rbroker-us1"
  vpc_security_group_ids = ["sg-0ede761da972c2900", "sg-0755f4c4ecea46847"]

  associate_public_ip_address = true
    tags = {
      Name = "rrb-webserver"
      Terraform   = "true"
      Environment = "dev"
    }

  user_data     = <<-EOF
                  #!/bin/bash
                  sudo yum -y install httpd
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF
}
##########################################################################
#  Appserver
#
resource "aws_instance" "appserver" {
  ami                    = "ami-0e01ce4ee18447327"
  instance_type          = "t2.micro"
  key_name               = "rbroker-us1"
  vpc_security_group_ids = ["sg-0ede761da972c2900", "sg-0755f4c4ecea46847"]

  associate_public_ip_address = true
    tags = {
      Name = "rrb-appserver"
      Terraform   = "true"
      Environment = "dev"
    }

  user_data     = <<-EOF
                  #!/bin/bash
                  sudo yum -y install tomcat tomcat-admin-webapps
                  sudo yum -y java install mysql-connector-java
                  sudo systemctl enable tomcat
                  #sudo systemctl start tomcat
                  EOF

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
