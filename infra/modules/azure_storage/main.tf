resource "azurerm_storage_account" "this" {
  name                = var.NAME
  resource_group_name = var.RESOURCE_GROUP_NAME
  location            = var.LOCATION

  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.TAGS
}

resource "azurerm_storage_container" "this" {
  name                  = var.CONTAINER_NAME
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
