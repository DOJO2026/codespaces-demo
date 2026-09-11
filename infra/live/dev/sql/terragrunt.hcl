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

  source = "../../../modules/sql"

}

inputs = {

  SQL_SERVER_NAME = get_env("TF_VAR_SQL_SERVER_NAME")

  DATABASE_NAME = get_env("TF_VAR_DATABASE_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  # Azure SQL logical servers can be blocked ("ProvisioningDisabled") in a
  # region that otherwise works fine for App Service / generic resources -
  # this is a per-subscription restriction, not a code issue. Set the
  # TF_VAR_SQL_LOCATION secret to a region your subscription allows for SQL
  # (e.g. "eastus") to override just this unit's region; if that secret
  # isn't set, it falls back to the same region as everything else.
  LOCATION = get_env("TF_VAR_SQL_LOCATION", dependency.resource_group.outputs.LOCATION)

  ADMINISTRATOR_LOGIN = get_env("TF_VAR_SQL_ADMIN_LOGIN")

  ADMINISTRATOR_PASSWORD = get_env("TF_VAR_SQL_ADMIN_PASSWORD")

  SKU_NAME = "Basic"

  MAX_SIZE_GB = 2

  TAGS = {

    Environment = "DEV"

    Project = "Codespaces-Demo"

    Owner = "DOJO2026"

  }

}