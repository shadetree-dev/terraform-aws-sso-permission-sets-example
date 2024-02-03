# do a lookup of the group by name, so we can use its ID
data "aws_identitystore_group" "groups" {
  # we have a count argument because we will potentially have more than one group
  count             = length(var.groups)
  identity_store_id = var.idstore

  alternate_identifier {
    unique_attribute {
      attribute_path = "DisplayName"
      # gets the name by iterator index, so we can get all values
      attribute_value = var.groups[count.index]
    }
  }
}