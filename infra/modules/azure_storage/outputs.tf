output "CONNECTION_STRING" {
  value     = azurerm_storage_account.this.primary_connection_string
  sensitive = true
}

output "CONTAINER_NAME" {
  value = azurerm_storage_container.this.name
}

output "ACCOUNT_NAME" {
  value = azurerm_storage_account.this.name
}
