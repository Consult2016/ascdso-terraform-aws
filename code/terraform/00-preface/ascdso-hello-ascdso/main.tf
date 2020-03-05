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
  vpc_security_group_ids = ["default"]

  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, ASCDSO!!!" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags = {
     Name = "ascdso-terraform-master"
  }
}
