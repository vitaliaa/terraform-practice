variable "aws_region" {
  description = "AWS region to launch servers"
  default     = "eu-west-1"
}

variable "aws_amis" {
  default = "ami-02df9ea15c1778c9c"
}

variable "name_of_instance" {
  default = "Ubuntu_server_18.04"
}
