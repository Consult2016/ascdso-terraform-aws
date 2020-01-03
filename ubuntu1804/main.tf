terraform {
  required_version = ">= 0.12, < 0.13"
}

provider"aws"{
  region="us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource"aws_instance" "ubuntu1804"{
  ami="ami-06d51e91cea0dac8d"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, ASCDSO" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "ascdso-ubuntu1804-master"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
