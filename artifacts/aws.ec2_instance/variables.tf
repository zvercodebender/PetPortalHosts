# Input variable definitions


variable "project" {
  description = "Project Name"
  type        = string
  default     = "ProjectName"
}

variable "ami" {
  description  = "AMI to use for servers"
  type         = string
  default      = "ami-0e01ce4ee18447327"
}

variable "aws_region" {
  description  = "AWS Region"
  type         = string
  default      = "us-east-2"
}


variable "my-sg" {
  type    = list(string)
  default = ["sg-0ede761da972c2900", "sg-0755f4c4ecea46847"]
}
