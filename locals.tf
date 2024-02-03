locals {
  # have to transform and get the index, so do it in locals for re-use
  sso_instance = tolist(data.aws_ssoadmin_instances.sso.arns)[0]

  # same with identity_store_id
  idstore = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]

  # get the values from our secrets and jsondecode
  policies = jsondecode(data.aws_secretsmanager_secret_version.policies.secret_string)
  accounts = jsondecode(data.aws_secretsmanager_secret_version.accounts.secret_string)
  groups   = jsondecode(data.aws_secretsmanager_secret_version.groups.secret_string)

  # matrix it all together into a map we can dig stuff out from
  # NOTE THAT THIS ONLY WORKS IF YOU HAVE THE SAME NUMBER OF ELEMENTS
  # which you should if you are following the blog post at
  # https://shadetree.dev for this
  full_map = nonsensitive({
    for k, v in local.policies :
    k => {
      policies = split(",", v)
      accounts = split(",", local.accounts[k])
      groups   = split(",", local.groups[k])
    }
  })

  # set some standard tags we can pass to resources
  tags = {
    Purpose    = "iam:sso"
    InspiredBy = "shadetree.dev"
  }
}