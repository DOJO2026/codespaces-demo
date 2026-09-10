output "SERVER_ID" {

  value = azurerm_mssql_server.this.id

}

output "SERVER_NAME" {

  value = azurerm_mssql_server.this.name

}

output "DATABASE_NAME" {

  value = azurerm_mssql_database.this.name

}

output "FQDN" {

  value = azurerm_mssql_server.this.fully_qualified_domain_name

}