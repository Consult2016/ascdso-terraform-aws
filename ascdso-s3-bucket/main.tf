terraform {
  required_version = ">= 0.12, < 0.13"
}

provider"aws"{
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "ascdso-up-and-running-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ascdso-up-and-running-locks"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state"{
 bucket = "ascdso-up-and-running-state"

  # Prevent accidental deletion of this S3 bucket
  lifecycle{
    prevent_destroy = true
  }

   # Enable versioning so we can see the full revision history of our  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "ascdso-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
     name = "LockID"
     type = "S"
    }
  }
