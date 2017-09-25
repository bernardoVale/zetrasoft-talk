
Crie uma instancia:
Utilize a ami que criamos antes

terraform.rf:
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_app" {
  count = 1
  ami = "ami-aed723d4"
  instance_type = "t2.micro"
}
```

Change to three:

```
resource "aws_instance" "my_app" {
  count = 3
  ami = "ami-aed723d4"
  instance_type = "t2.micro"
}
```

Add variables:
```
provider "aws" {
  region = "us-east-1"
}
variable "instance_count" {}
variable "instance_id" {}

resource "aws_instance" "my_app" {
  count = "${var.instance_count}"
  ami = "${var.instance_id}"
  instance_type = "t2.micro"
}
```

ami-aed723d4

Use a different ami 

plan/apply

finally add a loadbalancer and push to two instances:
```
resource "aws_elb" "my_app_lb" {
  name               = "zetra-terraform-elb"
  availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/app/"
    interval            = 30
  }

  instances                   = ["${aws_instance.my_app.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "zetra-example-elb"
  }
}
```