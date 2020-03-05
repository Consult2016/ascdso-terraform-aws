terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "ascdso-example" {
  ami           = "ami-0edf3b95e26a682df"
  instance_type = "t2.micro"

  tags = {
    Name = "ascdso-ec2-example"
  }
}
