resource "azurerm_cognitive_account" "this" {
  name                = var.NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME

  kind     = "OpenAI"
  sku_name = var.SKU_NAME

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
    name     = "GlobalStandard"
    capacity = var.MODEL_CAPACITY
  }
}

resource "azurerm_cognitive_deployment" "embedding" {
  name                 = var.EMBEDDING_DEPLOYMENT_NAME
  cognitive_account_id = azurerm_cognitive_account.this.id

  model {
    format  = "OpenAI"
    name    = var.EMBEDDING_MODEL_NAME
    version = var.EMBEDDING_MODEL_VERSION
  }

  sku {
    name     = "GlobalStandard"
    capacity = var.EMBEDDING_MODEL_CAPACITY
  }
}
