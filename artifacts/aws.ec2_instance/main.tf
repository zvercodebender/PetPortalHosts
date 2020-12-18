# Terraform configuration

provider "aws" {
  region = var.aws_region
  access_key = "{{AWS_ACCESS_KEY}}"
  secret_key = "{{AWS_SECRET_KEY}}"
}

##########################################################################
#  Webserver
#
module "webserver" {
    source = "./webserver"
    my-ami = var.ami
    my-sg = var.my-sg
}
##########################################################################
#  Appserver
#
module "appserver" {
    source = "./appserver"
    my-ami = var.ami
    my-sg = var.my-sg
}

##########################################################################
#  RDS Database
#
module "db" {
    source = "./db"
    my-sg = var.my-sg
}
