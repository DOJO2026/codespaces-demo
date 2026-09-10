include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/resource_group"
}

inputs = {

  RESOURCE_GROUP_NAME = get_env("TF_VAR_RESOURCE_GROUP_NAME")

  LOCATION = get_env("TF_VAR_LOCATION")

}