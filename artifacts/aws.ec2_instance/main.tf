# Terraform configuration

provider "aws" {
  region = "{{AWSRegion}}"
  access_key = "{{AWS_ACCESS_KEY}}"
  secret_key = "{{AWS_SECRET_KEY}}"
}

##########################################################################
#  Webserver
#
module "webserver" {
    source = "./webserver"
    my-sg = var.my-sg
}
##########################################################################
#  Appserver
#
module "appserver" {
    source = "./appserver"
    my-sg = var.my-sg
}

##########################################################################
#  RDS Database
#
module "db" {
    source = "./db"
    my-sg = var.my-sg
}
