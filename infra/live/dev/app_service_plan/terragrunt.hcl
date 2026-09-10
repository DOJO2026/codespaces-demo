include {
  path = find_in_parent_folders()
}

dependency "resource_group" {
  config_path = "../resource_group"
}

terraform {
  source = "../../../modules/app_service_plan"
}

inputs = {

  APP_SERVICE_PLAN_NAME = get_env("TF_VAR_APP_SERVICE_PLAN_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

  SKU_NAME = "B1"

  OS_TYPE = "Linux"

}