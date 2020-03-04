terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_db_instance" "ascdso" {
  identifier_prefix   = "ascdso-infrastructure"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  username            = "admin"
  skip_final_snapshot = true
  name                = var.db_name

  password            = var.db_password
# password            = data.aws_secretsmanager_secret_version.db_password.secret_string
}

# data"aws_secretsmanager_secret_version" "db_password" {
#   secret_id="mysql-master-password-stage"
# }

terraform {
  required_version = ">= 0.12, < 0.13"
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "ascdso-up-and-running-state"
    key            = "dev/data-storage/mysql/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ascdso-up-and-running-locks"
    encrypt        = true
  }
}
