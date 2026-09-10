include {
  path = find_in_parent_folders()
}

dependency "resource_group" {

  config_path = "../resource_group"

}

terraform {

  source = "../../../modules/sql"

}

inputs = {

  SQL_SERVER_NAME = get_env("TF_VAR_SQL_SERVER_NAME")

  DATABASE_NAME = get_env("TF_VAR_DATABASE_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

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