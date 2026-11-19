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

dependency "app_service_plan" {
  config_path = "../app_service_plan"

  mock_outputs = {
    ID   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mock-rg/providers/Microsoft.Web/serverFarms/mock-plan"
    NAME = "mock-plan"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "azure_openai" {
  config_path = "../azure_openai"

  mock_outputs = {
    ENDPOINT                  = "https://mock-openai.openai.azure.com/"
    PRIMARY_KEY               = "mock-openai-key"
    DEPLOYMENT_NAME           = "mock-deployment"
    EMBEDDING_DEPLOYMENT_NAME = "mock-embedding-deployment"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "azure_search" {
  config_path = "../azure_search"

  mock_outputs = {
    ENDPOINT    = "https://mock-search.search.windows.net"
    PRIMARY_KEY = "mock-search-key"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "sql" {
  config_path = "../sql"

  mock_outputs = {
    FQDN          = "mock-sql.database.windows.net"
    DATABASE_NAME = "mock-db"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "azure_storage" {
  config_path = "../azure_storage"

  mock_outputs = {
    CONNECTION_STRING = "mock-connection-string"
    CONTAINER_NAME    = "mock-container"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

terraform {
  source = "../../../modules/app_service"
}

inputs = {
  APP_NAME            = get_env("TF_VAR_BACKEND_APP_NAME")
  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME
  LOCATION            = dependency.resource_group.outputs.LOCATION
  APP_SERVICE_PLAN_ID = dependency.app_service_plan.outputs.ID

  RUNTIME   = "PYTHON"
  ALWAYS_ON = true

  APP_SETTINGS = {
    # false: el venv ya viene armado (antenv) dentro del zip que sube
    # backend.yml, compilado en el runner de GitHub Actions - no hace
    # falta (ni conviene) que Azure intente reconstruirlo en el plan B1.
    SCM_DO_BUILD_DURING_DEPLOYMENT = "false"
    WEBSITE_RUN_FROM_PACKAGE        = "1"

    AZURE_OAI_ENDPOINT             = dependency.azure_openai.outputs.ENDPOINT
    AZURE_OAI_KEY                  = dependency.azure_openai.outputs.PRIMARY_KEY
    AZURE_OAI_DEPLOYMENT           = dependency.azure_openai.outputs.DEPLOYMENT_NAME
    AZURE_OAI_EMBEDDING_DEPLOYMENT = dependency.azure_openai.outputs.EMBEDDING_DEPLOYMENT_NAME

    AZURE_SEARCH_ENDPOINT = dependency.azure_search.outputs.ENDPOINT
    AZURE_SEARCH_KEY      = dependency.azure_search.outputs.PRIMARY_KEY
    AZURE_SEARCH_INDEX    = "docs-index"

    AZURE_SQL_SERVER   = dependency.sql.outputs.FQDN
    AZURE_SQL_DATABASE = dependency.sql.outputs.DATABASE_NAME
    AZURE_SQL_USER     = get_env("TF_VAR_SQL_ADMIN_LOGIN")
    AZURE_SQL_PASSWORD = get_env("TF_VAR_SQL_ADMIN_PASSWORD")

    AZURE_STORAGE_CONNECTION_STRING = dependency.azure_storage.outputs.CONNECTION_STRING
    AZURE_STORAGE_CONTAINER         = dependency.azure_storage.outputs.CONTAINER_NAME

    WEBSITES_PORT = "8000"
  }

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }
}
