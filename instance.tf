provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


resource "aws_instance" "Ubuntu_test" {
  ami                    = "ami-02df9ea15c1778c9c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

  tags = {
    Name = "Name of instance"
  }
}


resource "aws_security_group" "sec_group" {
  name        = "HTTP-HTTPS"
  description = "HTTP-HTTPS"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


