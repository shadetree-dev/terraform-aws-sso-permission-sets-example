terraform {
  backend "s3" {
    bucket               = "shadetree-dev-backend"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "workspaces/sso-demo"
    dynamodb_table       = "shadetree-dev-backend-lock"
    encrypt              = true
    region               = "us-west-2"
  }
}