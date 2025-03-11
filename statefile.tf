###################################### Dev  ####################################################
terraform {
  backend "s3" {}
}

data "aws_caller_identity" "account_id" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "vpc/vpc-state.tfstate"
    region = var.remote_state_region
  }
}
