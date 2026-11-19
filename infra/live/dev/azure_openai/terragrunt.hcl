include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "resource_group" {
  config_path = "../resource_group"

  mock_outputs = {
    RESOURCE_GROUP_NAME = "mock-resource-group"
    LOCATION            = "eastus2"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

terraform {
  source = "../../../modules/azure_openai"
}

inputs = {
  NAME                = get_env("TF_VAR_OPENAI_ACCOUNT_NAME")
  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME
  LOCATION            = dependency.resource_group.outputs.LOCATION

  SKU_NAME = "S0"

  DEPLOYMENT_NAME = "chat-deployment"
  MODEL_NAME      = "gpt-5-mini"
  MODEL_VERSION   = "2025-08-07"
  MODEL_CAPACITY  = 1

  EMBEDDING_DEPLOYMENT_NAME = "embedding-deployment"
  EMBEDDING_MODEL_NAME      = "text-embedding-ada-002"
  EMBEDDING_MODEL_VERSION   = "2"
  EMBEDDING_MODEL_CAPACITY  = 1

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }
}
