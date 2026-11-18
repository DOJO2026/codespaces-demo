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
  source = "../../../modules/azure_search"
}

inputs = {

  # Must be globally unique. Comes from a GitHub secret, same pattern as
  # TF_VAR_BACKEND_APP_NAME.
  NAME = get_env("TF_VAR_SEARCH_SERVICE_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  # Fijado a otra región que la del Resource Group (eastus2) - eastus2
  # está sin capacidad ahora mismo para Search Basic tier.
  LOCATION = "eastus"

  SKU = "basic"

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }

}