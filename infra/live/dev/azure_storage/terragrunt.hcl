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
  source = "../../../modules/azure_storage"
}

inputs = {
  # Debe ser globalmente unico, viene de un GitHub secret, mismo patron que
  # TF_VAR_OPENAI_ACCOUNT_NAME / TF_VAR_SEARCH_SERVICE_NAME.
  NAME = get_env("TF_VAR_STORAGE_ACCOUNT_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME
  LOCATION            = dependency.resource_group.outputs.LOCATION

  CONTAINER_NAME = "contenedor"

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }
}
