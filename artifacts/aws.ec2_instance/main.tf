# Terraform configuration

provider "aws" {
  region = var.AWSRegion
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

##########################################################################
#  Webserver
#
resource "aws_instance" "webserver" {
  ami                    = "ami-0e01ce4ee18447327"
  instance_type          = "t2.micro"
//  key_name               = "rbroker-us1"
  vpc_security_group_ids = ["sg-0c0c05ed8824304f4", "sg-00385650dc20566a2"]

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
//  key_name               = "rbroker-us1"
  vpc_security_group_ids = ["sg-0c0c05ed8824304f4", "sg-00385650dc20566a2"]

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
      private_key = file("~/.ssh/bnechyporenko.pem")
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
      private_key = file("~/.ssh/bnechyporenko.pem")
      host        = self.public_dns
    }
  }
  provisioner "file" {
    source      = "${path.module}/resources/install-mysql-driver.sh"
    destination = "~/resources/install-mysql-driver.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/bnechyporenko.pem")
      host        = self.public_dns
    }
  }
  provisioner "file" {
    source      = "${path.module}/resources/mgmt-users.properties"
    destination = "~/resources/mgmt-users.properties"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/bnechyporenko.pem")
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
      private_key = file("~/.ssh/bnechyporenko.pem")
      host        = self.public_dns
    }
  }
}

##########################################################################
#  RDS Database
#
resource "aws_db_instance" "mysqldb" {
  allocated_storage    = 100
  engine               = "mysql"
  engine_version       = "5.7.19"
  identifier           = "mysqldb"
  instance_class       = "db.t2.micro"
  password             = "{{DB_USERNAME}}"
  skip_final_snapshot  = true
  storage_encrypted    = false
  username             = "{{DB_PASSWORD}}"
  vpc_security_group_ids = ["sg-0c0c05ed8824304f4", "sg-00385650dc20566a2"]
}
