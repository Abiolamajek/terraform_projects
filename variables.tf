variable "aws_region" {
  default = "us-west-1"
  type    = string
}

variable "ami_id" {
  default = "ami-073e64e4c237c08ad"
  type    = string
}

variable "instance" {
  default = "t2.micro"
  type    = string
}

variable "key" {
  default = "danny"
  type    = string
}
