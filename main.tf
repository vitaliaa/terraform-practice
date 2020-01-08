provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


resource "aws_instance" "test" {
  ami                    = "ami-02df9ea15c1778c9c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sec_group.id]

  tags = {
    Name = "Name of instance"
  }
}


resource "aws_security_group" "sec_group" {
  name        = "HTTP-SSH"
  description = "HTTP-SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
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


