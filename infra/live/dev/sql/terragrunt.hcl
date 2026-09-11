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
  # this is a per-subscription/region restriction from Azure, not a code
  # issue. Hardcoded here (not a secret - it's not sensitive) since your
  # subscription currently allows SQL provisioning in "centralus" but not
  # in "East US 2" (where everything else lives). Change this literal
  # value directly if you need a different region later - no GitHub secret
  # required.
  #
  # Named SQL_LOCATION (not LOCATION) on purpose - see the comment on the
  # module's SQL_LOCATION variable for why reusing "LOCATION" here silently
  # broke this exact override (the job-level TF_VAR_LOCATION env var won).
  SQL_LOCATION = get_env("TF_VAR_SQL_LOCATION", "centralus")

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