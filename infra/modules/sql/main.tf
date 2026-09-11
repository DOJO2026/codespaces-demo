resource "azurerm_mssql_server" "this" {

  name = var.SQL_SERVER_NAME

  resource_group_name = var.RESOURCE_GROUP_NAME

  location = var.SQL_LOCATION

  version = "12.0"

  administrator_login = var.ADMINISTRATOR_LOGIN

  administrator_login_password = var.ADMINISTRATOR_PASSWORD

  minimum_tls_version = "1.2"

  public_network_access_enabled = true

  tags = var.TAGS

}

resource "azurerm_mssql_database" "this" {

  name = var.DATABASE_NAME

  server_id = azurerm_mssql_server.this.id

  sku_name = var.SKU_NAME

  max_size_gb = var.MAX_SIZE_GB

  tags = var.TAGS

}