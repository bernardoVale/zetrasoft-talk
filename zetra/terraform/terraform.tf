provider "aws" {
  region = "us-east-1"
}
variable "instance_count" {}
variable "instance_id" {}
# 1
# ami-99134c8f

# ami-3af90d40
# ami-9b86fe8d
# ami-99134c8f
resource "aws_instance" "my_app" {
  count = "${var.instance_count}"
  ami = "${var.instance_id}"
  instance_type = "t2.micro"
}