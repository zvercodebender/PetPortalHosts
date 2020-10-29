# Terraform configuration

provider "aws" {
  region = "{{AWSRegion}}"
  access_key = "{{AWS_ACCESS_KEY}}"
  secret_key = "{{AWS_SECRET_KEY}}"
}


resource "aws_instance" "bdd" {
  ami                    = "ami-0e01ce4ee18447327"
  instance_type          = "t2.micro"
  key_name               = "rbroker-us1"
  vpc_security_group_ids = ["sg-0ede761da972c2900", "sg-0755f4c4ecea46847"]

  associate_public_ip_address = true
    tags = {
      Name = "rrb-ec2-instance"
      Terraform   = "true"
      Environment = "dev"
    }

  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  sudo yum -y install tomcat tomcat-admin-webapps
                  sudo systemctl enable tomcat
                  sudo systemctl start tomcat
                  wget https://download.jboss.org/wildfly/21.0.0.Final/wildfly-21.0.0.Final.zip
                  EOF
}
