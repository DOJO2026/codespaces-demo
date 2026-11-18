output "ENDPOINT" {
  value = azurerm_cognitive_account.this.endpoint
}

output "PRIMARY_KEY" {
  value     = azurerm_cognitive_account.this.primary_access_key
  sensitive = true
}

output "DEPLOYMENT_NAME" {
  value = azurerm_cognitive_deployment.this.name
}
