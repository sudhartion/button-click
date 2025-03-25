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

resource "aws_instance" "scarlet" {
  tags = {
    Name = "Scarlet"
  }
  ami = "ami-0f174d97d7d7a029b" # Red Hat Enterprise Linux 9 (HVM), SSD Volume Type
  instance_type = "t3.micro"
  key_name = "First"
  vpc_security_group_ids = ["sg-07e63de8a0fd2f973"]
  availability_zone = "eu-north-1b"
}
