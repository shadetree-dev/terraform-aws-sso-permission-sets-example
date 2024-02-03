# get our SSO instances, of which there should just be 1...
data "aws_ssoadmin_instances" "sso" {}

# look up our secret for managed policies
data "aws_secretsmanager_secret" "policies" {
  name = "/aws/org/sso/managed-policies"
}

# get the latest version of it, so we can get the actual data
data "aws_secretsmanager_secret_version" "policies" {
  secret_id = data.aws_secretsmanager_secret.policies.id
}

# look up our secret for account mapping
data "aws_secretsmanager_secret" "accounts" {
  name = "/aws/org/sso/account-mapping"
}

# get the latest version of it, so we can get the actual data
data "aws_secretsmanager_secret_version" "accounts" {
  secret_id = data.aws_secretsmanager_secret.accounts.id
}

# look up our secret for group mapping
data "aws_secretsmanager_secret" "groups" {
  name = "/aws/org/sso/group-mapping"
}

# get the latest version of it, so we can get the actual data
data "aws_secretsmanager_secret_version" "groups" {
  secret_id = data.aws_secretsmanager_secret.groups.id
}