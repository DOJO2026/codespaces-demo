resource "azurerm_linux_web_app" "this" {

  name                = var.APP_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME

  service_plan_id = var.APP_SERVICE_PLAN_ID

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {

    always_on = var.ALWAYS_ON

    application_stack {

      # The azurerm provider requires java_server, java_server_version AND
      # java_version to all be set together (or all left null) - setting
      # java_version alone fails validation. "JAVA" as the server means
      # Java SE (no Tomcat/JBoss), which is what a Spring Boot fat jar
      # (run via `java -jar`) needs.
      java_server         = var.RUNTIME == "JAVA" ? "JAVA" : null
      java_server_version = var.RUNTIME == "JAVA" ? "17" : null
      java_version         = var.RUNTIME == "JAVA" ? "17" : null

      node_version = var.RUNTIME == "NODE" ? "20-lts" : null

      # FastAPI backend. No app_command_line override here on purpose -
      # same pattern you already use for NODE: the startup command
      # (uvicorn, in this case) gets set from backend.yml via
      # `az webapp config set --startup-file`, not from Terraform, so it
      # lives next to the rest of the deploy-time configuration instead
      # of being split across two places.
      python_version = var.RUNTIME == "PYTHON" ? "3.12" : null

    }

  }

  app_settings = var.APP_SETTINGS

  tags = var.TAGS

}