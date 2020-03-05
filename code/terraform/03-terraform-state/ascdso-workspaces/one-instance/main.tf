terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "ascdso-state"
    key            = "ascdso-workspaces/one-instance/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ascdso-locks"
    encrypt        = true
  }
}

resource "aws_instance" "ascdso-workspace-master" {
  ami           = "ami-0edf3b95e26a682df"
  instance_type = "t2.micro"

  tags = {
         Name = "ascdso-workspaces-master"
  }

}
