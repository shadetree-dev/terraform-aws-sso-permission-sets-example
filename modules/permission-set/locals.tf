locals {
  # gotta normalize our policies and construct ARNs!
  policies = [
    for policy in var.policies :
    # finance has a different prefix for the Billing policy; all others are normal in our case
    policy == "Billing" ? "arn:aws:iam::aws:policy/job-function/Billing" : "arn:aws:iam::aws:policy/${policy}"
  ]

  # we are passing in kinda bogus data, so we want to matrix these together now
  # we could have N by M elements, and so we need a map where there is parity
  group_assignments = nonsensitive(flatten([
    for group in data.aws_identitystore_group.groups : [
      for account in var.accounts : {
        # set these attributs, which we will access via [index].<thisvalue>
        group_id = group.group_id
        account  = account
      }
    ]
  ]))
}