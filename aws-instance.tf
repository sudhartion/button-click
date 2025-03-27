# Required environment variables:
# AWS_CONFIG_FILE = "path/to/aws/config"
# AWS_SHARED_CREDENTIALS_FILE = "path/to/aws/credentials"
# AWS_PROFILE = "profile-name" (optional for profile "default")

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_security_group" "button-click-security" {
  name = "button-click-security"
  description = "Security Group for Button Click infrastructure"
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.button-click-security.id
  description = "Allow SSH"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.button-click-security.id
  description = "Allow HTTP"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow-https" {
  security_group_id = aws_security_group.button-click-security.id
  description = "Allow HTTPS"
  ip_protocol = "tcp"
  from_port = 443
  to_port = 443
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.button-click-security.id
  description = "Allow all traffic"
  ip_protocol = "all"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_key_pair" "button-click-infra-access" {
  key_name = "button-click-infra-access"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ3vDXT/3JR3ncuV6wK6sDXqjgLZ+jc7DoQyhonf54PQ"
}

resource "aws_instance" "button-click-server" {
  tags = {
    Name = "Button Click Server"
  }
  ami = "ami-0f174d97d7d7a029b" # Red Hat Enterprise Linux 9 (HVM), SSD Volume Type
  instance_type = "t3.micro"
  key_name = aws_key_pair.button-click-infra-access.key_name
  vpc_security_group_ids = [aws_security_group.button-click-security.id]
  availability_zone = "eu-north-1b"
}
