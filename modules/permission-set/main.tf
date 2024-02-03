# creates a new IAM Identity Center Permission Set with our parameters
# the PS itself is quite simple, so we just create one to then attach to stuff
resource "aws_ssoadmin_permission_set" "ps" {
  name             = var.name
  description      = "Permission Set created via Terraform for ${var.name} business function"
  instance_arn     = var.sso_instance
  session_duration = var.session_duration
  tags             = var.tags
}

# we could have multiple policies, so we want to make sure we attach each one
# even though this happens separately from account assignment, there is
# a slightly more than implicit dependency that can cause it to break if you don't
# set the depends_on
resource "aws_ssoadmin_managed_policy_attachment" "attach" {
  # iterate our policies
  count        = length(local.policies)
  depends_on   = [aws_ssoadmin_account_assignment.accounts]
  instance_arn = var.sso_instance
  # each policy is represented by an index in the list (array)
  managed_policy_arn = local.policies[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.ps.arn
}

# account assignments happen somewhat independently of permissions
# but have some race conditions associated with them
# chances are, if you have some apply and some fail, a re-init and apply
# will likely solve it
resource "aws_ssoadmin_account_assignment" "accounts" {
  # iterate over all our group assignments, which have a goofy map built
  count        = length(local.group_assignments)
  instance_arn = var.sso_instance
  # each index has a map value, which we access
  principal_id   = local.group_assignments[count.index].group_id
  principal_type = "GROUP"
  # each index has a map value, which we access
  target_id   = local.group_assignments[count.index].account
  target_type = "AWS_ACCOUNT"
  # re-provisions the PS when account list gets updated
  permission_set_arn = aws_ssoadmin_permission_set.ps.arn
}