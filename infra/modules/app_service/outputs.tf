output "ID" {
  value = azurerm_linux_web_app.this.id
}

output "NAME" {
  value = azurerm_linux_web_app.this.name
}

output "DEFAULT_HOSTNAME" {
  value = azurerm_linux_web_app.this.default_hostname
}

output "PRINCIPAL_ID" {
  value = azurerm_linux_web_app.this.identity[0].principal_id
}