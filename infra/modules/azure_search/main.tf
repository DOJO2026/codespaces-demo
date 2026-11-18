resource "azurerm_search_service" "this" {
  name                = var.NAME
  resource_group_name = var.RESOURCE_GROUP_NAME
  location            = var.LOCATION

  sku = var.SKU

  # 1/1 is enough for a demo workload - raise these later if you need
  # more throughput or high availability.
  replica_count   = 1
  partition_count = 1

  tags = var.TAGS
}
