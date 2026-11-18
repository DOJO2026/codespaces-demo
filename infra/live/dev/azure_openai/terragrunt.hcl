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

terraform {
  source = "../../../modules/azure_openai"
}

inputs = {

  # Must be globally unique (it's part of the endpoint hostname). Comes
  # from a GitHub secret, same pattern as TF_VAR_BACKEND_APP_NAME.
  NAME = get_env("TF_VAR_OPENAI_ACCOUNT_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

  SKU_NAME = "S0"

  # This is the exact string that ends up as AZURE_OAI_DEPLOYMENT in the
  # backend's app settings (wired automatically via the dependency block
  # in backend/terragrunt.hcl) - you're choosing this name, Azure doesn't
  # assign it.
  DEPLOYMENT_NAME = "chat-deployment"

  MODEL_NAME     = "gpt-4o-mini"
  MODEL_VERSION  = "2024-07-18"
  MODEL_CAPACITY = 1

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }

}
