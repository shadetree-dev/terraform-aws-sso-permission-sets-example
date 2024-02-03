provider "aws" {
  region = var.region
  # for local use, if you can assume the role specified no changes required
  # otherwise, you can use your local SSO profile by commenting OUT assume_role
  # and commenting in your profile
  profile = "automation"
  #   assume_role {
  #     role_arn = "arn:aws:iam::${var.account_id}:role/OrganizationAccountAccessRole"
  #   }
}