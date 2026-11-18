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

dependency "azure_openai" {
  config_path = "../azure_openai"

  mock_outputs = {
    ENDPOINT        = "https://mock-openai.openai.azure.com/"
    PRIMARY_KEY     = "mock-openai-key"
    DEPLOYMENT_NAME = "mock-deployment"
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

terraform {
  source = "../../../modules/app_service"
}

inputs = {

  APP_NAME = get_env("TF_VAR_BACKEND_APP_NAME")

  RESOURCE_GROUP_NAME = dependency.resource_group.outputs.RESOURCE_GROUP_NAME

  LOCATION = dependency.resource_group.outputs.LOCATION

  APP_SERVICE_PLAN_ID = dependency.app_service_plan.outputs.ID

  # Switched from JAVA (Spring Boot) to PYTHON (FastAPI) - see
  # modules/app_service/main.tf for what this changes (python_version in
  # application_stack). The uvicorn startup command itself is set from
  # backend.yml via `az webapp config set`, same pattern as pm2 for the
  # frontend - not from Terraform.
  RUNTIME = "PYTHON"

  ALWAYS_ON = true

  APP_SETTINGS = {
    # Lets Azure's Oryx build system run "pip install -r requirements.txt"
    # automatically during the zip deploy in backend.yml, since the
    # package no longer builds a deployable artifact (a JAR) in CI the way
    # Maven did.
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"

    # Pulled straight from the azure_openai and azure_search units above -
    # no manual copy/paste into GitHub Secrets, no drift between what
    # Terraform created and what the app actually uses. Re-running
    # infra.yml keeps these in sync automatically.
    AZURE_OAI_ENDPOINT    = dependency.azure_openai.outputs.ENDPOINT
    AZURE_OAI_KEY         = dependency.azure_openai.outputs.PRIMARY_KEY
    AZURE_OAI_DEPLOYMENT  = dependency.azure_openai.outputs.DEPLOYMENT_NAME

    AZURE_SEARCH_ENDPOINT = dependency.azure_search.outputs.ENDPOINT
    AZURE_SEARCH_KEY      = dependency.azure_search.outputs.PRIMARY_KEY
    # Just a name - the index schema itself still needs to be created
    # separately (Terraform has no resource for Azure AI Search index
    # schemas). See the note I'm sending with this file.
    AZURE_SEARCH_INDEX    = "docs-index"

    WEBSITES_PORT = "8000"
  }

  TAGS = {
    Environment = "DEV"
    Project     = "Codespaces-Demo"
    Owner       = "DOJO2026"
  }

}
