variable "AZURE_SUBSCRIPTION_ID" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "APP_SERVICE_PLAN_NAME" {
  type = string
}

variable "BACKEND_APP_NAME" {
  type = string
}

variable "FRONTEND_APP_NAME" {
  type = string
}

variable "SQL_SERVER_NAME" {
  type = string
}

variable "DATABASE_NAME" {
  type = string
}

variable "SQL_ADMIN_LOGIN" {
  type = string
}

variable "SQL_ADMIN_PASSWORD" {
  type      = string
  sensitive = true
}