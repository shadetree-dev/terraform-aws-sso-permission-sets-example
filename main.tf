# calls our nasty little module to map all of our
# disparate data into one, cohesive set of permissions!
module "permission-set" {
  source = "./modules/permission-set"
  # use a map we have constructed with disparate elements we will use for individual vars
  for_each = local.full_map
  # SSO instance is static so we just look it up once
  sso_instance = local.sso_instance
  # same as SSO instance in behavior
  idstore = local.idstore
  # the name is our common "index" across secrets so we've got it as a key
  name = each.key
  # policies are sent as a list, split from comma-delimited strings
  policies = each.value["policies"]
  # accounts are sent as a list, split from comma-delimited strings
  accounts = each.value["accounts"]
  # groups are sent as a list, split from comma-delimited strings
  groups = each.value["groups"]
}