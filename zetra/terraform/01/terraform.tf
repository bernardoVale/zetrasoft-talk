provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_app" {
  count = 2
  ami = "ami-aed723d4"
  instance_type = "t2.micro"
}