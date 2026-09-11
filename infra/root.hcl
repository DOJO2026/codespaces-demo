locals {

  environment = "dev"

  location = "East US 2"

  project = "codespaces-demo"

}

# Every unit (resource_group, app_service_plan, backend, frontend, sql) points its
# `terraform.source` at a bare module under infra/modules/**, so nothing outside that
# module folder is copied into the plan. Without this block none of the units carry a
# `provider "azurerm"` block and `terragrunt run --all ...` fails immediately with
# "Insufficient features blocks". This generates the same provider.tf into every unit.
generate "provider" {

  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
EOF
}

# Estado remoto para que las ejecuciones de CI 
#compartan el historial en lugar de comenzar desde un archivo 
#de estado local vacío cada vez (lo que haría que Terragrunt 
#intentara recrear recursos que ya existen a partir de la segunda ejecución).

# El grupo de recursos y la cuenta de almacenamiento
#que se indican a continuación deben existir ANTES de la primera ejecución.
# Créelos manualmente una sola vez (consulte el archivo 
#README/notas de configuración de la infraestructura); no se crean mediante esta canalización.

remote_state {

  backend = "azurerm"

  config = {

    subscription_id      = get_env("ARM_SUBSCRIPTION_ID")
    resource_group_name  = get_env("TF_STATE_RESOURCE_GROUP_NAME")
    storage_account_name = get_env("TF_STATE_STORAGE_ACCOUNT_NAME")
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"

    # Authenticate to the state storage account with the same OIDC identity
    # used for everything else instead of a separate storage account key.
    use_azuread_auth = true

  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

}

inputs = {

  LOCATION = local.location

}
