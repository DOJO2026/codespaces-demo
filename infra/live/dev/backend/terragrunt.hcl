include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "resource_group" {
  config_path = "../resource_group"

  mock_outputs = {
    RESOURCE_GROUP_NAME = "mock-resource-group"
    LOCATION             = "eastus2"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "app_service_plan" {
  config_path = "../app_service_plan"

  mock_outputs = {
    ID   = "mock-app-service-plan-id"
    NAME = "mock-app-service-plan"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

terraform {
  source = "../../../modules/app_service"
}

inputs = {

  APP_NAME = get_env("TF_VAR_BACKEND_APP_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

  APP_SERVICE_PLAN_ID = dependency.app_service_plan.outputs.ID

  RUNTIME = "JAVA"

  ALWAYS_ON = true

  APP_SETTINGS = {
    SPRING_PROFILES_ACTIVE = "dev"
  }

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }

}