provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Udacity_T2" {
  count = var.instance_count_T2
  ami = var.ami
  instance_type = var.instance_type_T2
  tags = {
    Name   = "Udacity T2"
  }
}  

resource "aws_instance" "Udacity_M4" {
  count = var.instance_count_M4
  ami = var.ami
  instance_type = var.instance_type_M4
  tags = {
    Name   = "Udacity M4"
  }
}  

