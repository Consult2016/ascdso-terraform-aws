provider"aws"{
  region="us-west-2"
}

resource"aws_instance" "rhel8"{
  ami="ami-087c2c50437d0b80d"
  instance_type="t2.micro"

  tags = {
    Name = "ascdso-rhel8-master"
  }
}
