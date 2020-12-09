# Input variable definitions


variable "project" {
  description = "Project Name"
  type        = string
  default     = "ProjectName"
}

variable "my-sg" {
  type = list(string)
  default = ["sg-0ede761da972c2900", "sg-0755f4c4ecea46847"]
}
