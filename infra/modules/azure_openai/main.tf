resource "azurerm_cognitive_account" "this" {
  name                = var.NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME

  kind     = "OpenAI"
  sku_name = var.SKU_NAME

  # No private networking in this demo yet - the backend reaches this
  # over the public endpoint using the key, same trust model as the
  # SQL server.
  public_network_access_enabled = true

  tags = var.TAGS
}

resource "azurerm_cognitive_deployment" "this" {
  name                 = var.DEPLOYMENT_NAME
  cognitive_account_id = azurerm_cognitive_account.this.id

  model {
    format  = "OpenAI"
    name    = var.MODEL_NAME
    version = var.MODEL_VERSION
  }

  sku {
    name     = "Standard"
    capacity = var.MODEL_CAPACITY
  }
}
