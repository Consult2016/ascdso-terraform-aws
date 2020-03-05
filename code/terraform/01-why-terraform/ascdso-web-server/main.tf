terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "ascdso-app" {
  instance_type     = "t2.micro"
  availability_zone = "us-west-2b"
  ami               = "ami-0edf3b95e26a682df"
  
  user_data = <<-EOF
              #!/bin/bash
              sudo service apache2 start
              EOF

  tags = {
         Name = "ascdso-webapp-master"
  }
}
