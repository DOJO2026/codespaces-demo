resource "azurerm_service_plan" "this" {

  name = var.APP_SERVICE_PLAN_NAME

  location = var.LOCATION

  resource_group_name = var.RESOURCE_GROUP_NAME

  os_type = var.OS_TYPE

  sku_name = var.SKU_NAME

}