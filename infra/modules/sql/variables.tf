variable "SQL_SERVER_NAME" {
  type = string
}

variable "DATABASE_NAME" {
  type = string
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "SQL_LOCATION" {
  # Deliberately NOT named "LOCATION" - the GitHub Actions job exports
  # TF_VAR_LOCATION at job level (for resource_group/app_service_plan/
  # backend/frontend), and Terraform auto-maps any TF_VAR_<name> env var to
  # var.<name>. A variable named LOCATION here would collide with that
  # inherited env var and silently win over whatever Terragrunt's `inputs`
  # block tries to pass in for this unit specifically.
  type = string
}

variable "ADMINISTRATOR_LOGIN" {
  type = string
}

variable "ADMINISTRATOR_PASSWORD" {
  type      = string
  sensitive = true
}

variable "SKU_NAME" {
  type    = string
  default = "Basic"
}

variable "MAX_SIZE_GB" {
  type    = number
  default = 2
}

variable "TAGS" {
  type    = map(string)
  default = {}
}