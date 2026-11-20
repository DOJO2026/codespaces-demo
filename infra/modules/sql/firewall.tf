# Sin esto, NINGUN recurso de Azure (ni el backend ni ningun otro App
# Service) puede conectarse al SQL Server - por defecto Azure SQL bloquea
# todo trafico entrante. start_ip_address = end_ip_address = "0.0.0.0" es
# un valor especial que Azure reconoce como "Allow Azure services and
# resources to access this server" (el mismo checkbox que existe en el
# Portal) - permite trafico desde cualquier recurso de Azure, no de una IP
# puntual (que ademas puede rotar). database.yml ya maneja POR SEPARADO una
# regla temporal para el runner de GitHub (se crea y se borra en el mismo
# run) - esta es la regla permanente para el backend en si.
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
