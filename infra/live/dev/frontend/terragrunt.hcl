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

  # Must look like a real Azure App Service Plan resource ID: the azurerm
  # provider parses/validates this ID's shape even during `plan` (it's a
  # known value, not "known after apply"), so a plain placeholder string
  # like "mock-app-service-plan-id" fails with a segment-count error.
  mock_outputs = {
    ID   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mock-resource-group/providers/Microsoft.Web/serverFarms/mock-app-service-plan"
    NAME = "mock-app-service-plan"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
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