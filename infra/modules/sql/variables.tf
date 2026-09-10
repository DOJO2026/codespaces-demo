variable "SQL_SERVER_NAME" {
  type = string
}

variable "DATABASE_NAME" {
  type = string
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
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