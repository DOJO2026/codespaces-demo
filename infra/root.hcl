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

# Remote state so CI runs share history instead of starting from an empty local
# state file every time (which would make terragrunt try to re-create resources
# that already exist on the 2nd run and onward).
#
# The resource group + storage account + container get created automatically
# by the workflow's "Terragrunt Backend Bootstrap" step - but that step runs
# `terragrunt backend bootstrap` (no --all) from inside the resource_group
# unit specifically, not across every unit. Two reasons:
#   1. All 5 units share this exact same backend (same storage account/
#      container, only `key` differs per unit) - bootstrapping once is enough.
#   2. `backend bootstrap --all` tries to fully evaluate every unit, including
#      their `dependency` blocks - which fails before resource_group's own
#      state (and therefore backend) exists yet. resource_group has no
#      `dependency` block, so bootstrapping through it avoids that entirely.
# `location` is a literal here (not `local.location`) because this bootstrap
# phase does not reliably resolve `locals` references.
remote_state {

  backend = "azurerm"

  config = {

    subscription_id      = get_env("ARM_SUBSCRIPTION_ID")
    resource_group_name  = get_env("TF_STATE_RESOURCE_GROUP_NAME")
    storage_account_name = get_env("TF_STATE_STORAGE_ACCOUNT_NAME")
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    location              = "eastus2"

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
