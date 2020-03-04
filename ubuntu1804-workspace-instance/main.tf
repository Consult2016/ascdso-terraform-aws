terraform {
  required_version = ">= 0.12, < 0.13"
}

provider"aws"{
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
  region="us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource"aws_instance" "ubuntu1804"{
  ami="ami-06d51e91cea0dac8d"
  instance_type="t2.micro"
  tags = {
    Name = "ascdso-ubuntu1804-master"
  }
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "ascdso-up-and-running-state"
    key            = "workspaces-ascdso/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ascdso-up-and-running-locks"
    encrypt        = true
  }
}
