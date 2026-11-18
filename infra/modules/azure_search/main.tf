resource "azurerm_search_service" "this" {
  name                = var.NAME
  resource_group_name = var.RESOURCE_GROUP_NAME

  # Hardcoded here, not passed in from terragrunt.hcl as a variable:
  # eastus2 has repeatedly been "out of resources" for new Search services,
  # and editing the wrong terragrunt.hcl file (there are two similarly
  # named ones, azure_openai and azure_search) kept silently reverting this
  # back to eastus2. Putting it directly in the module removes that whole
  # class of mistake - there's no input left to get wrong.
  location = "eastus"

  sku = var.SKU

  # 1/1 is enough for a demo workload - raise these later if you need
  # more throughput or high availability.
  replica_count   = 1
  partition_count = 1

  tags = var.TAGS
}
