terraform {
  required_version = ">= 0.12, < 0.13"
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "ascdso-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ascdso-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_db_instance" "ascdso-db" {
  identifier_prefix   = "ascdso-terraform-aws"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"

  username            = "ascdso2020"

  name                = var.db_name
  skip_final_snapshot = true

  password            = var.db_password
}
