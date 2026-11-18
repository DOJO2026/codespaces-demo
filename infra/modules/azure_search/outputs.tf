output "ENDPOINT" {
  value = "https://${azurerm_search_service.this.name}.search.windows.net"
}

output "PRIMARY_KEY" {
  value     = azurerm_search_service.this.primary_key
  sensitive = true
}
