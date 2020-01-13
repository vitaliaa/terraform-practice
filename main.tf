provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


resource "aws_instance" "test" {
  ami                    = var.aws_amis
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  key_name               = "terraform_ec2_key"

  tags = {
    Name = var.name_of_instance
  }
  
	user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install apache2
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer IP: $myip</h2>" > /var/www/html/index.html
sudo systemctl start apache2 
EOF

}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "sec_group" {
  name        = "HTTP-SSH"
  description = "Access-HTTP-SSH"

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


