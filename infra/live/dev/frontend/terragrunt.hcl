include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "resource_group" {
  config_path = "../resource_group"
}

dependency "app_service_plan" {
  config_path = "../app_service_plan"
}

terraform {
  source = "../../../modules/app_service"
}

inputs = {

  APP_NAME = get_env("TF_VAR_FRONTEND_APP_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

  APP_SERVICE_PLAN_ID = dependency.app_service_plan.outputs.ID

  RUNTIME = "NODE"

  ALWAYS_ON = true

  APP_SETTINGS = {
    WEBSITE_NODE_DEFAULT_VERSION = "~20"
  }

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }

}