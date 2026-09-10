resource "azurerm_linux_web_app" "this" {

  name                = var.APP_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME

  service_plan_id = var.APP_SERVICE_PLAN_ID

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {

    always_on = var.ALWAYS_ON

    application_stack {

      java_version = var.RUNTIME == "JAVA" ? "17" : null

      node_version = var.RUNTIME == "NODE" ? "20-lts" : null

    }

  }

  app_settings = var.APP_SETTINGS

  tags = var.TAGS

}