include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "resource_group" {
  config_path = "../resource_group"

  # Lets `init`/`validate`/`plan` succeed before resource_group has ever been
  # applied (its real outputs don't exist yet on a first-ever run across all
  # units). `apply` is NOT in the allowed-commands list, so it always
  # requires the real values - which will exist by the time apply reaches
  # this unit, since `run --all apply` applies resource_group first.
  mock_outputs = {
    RESOURCE_GROUP_NAME = "mock-resource-group"
    LOCATION             = "eastus2"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
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