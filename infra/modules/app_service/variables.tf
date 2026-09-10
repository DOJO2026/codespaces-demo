variable "APP_NAME" {
  type = string
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "APP_SERVICE_PLAN_ID" {
  type = string
}

variable "RUNTIME" {
  type = string
}

variable "ALWAYS_ON" {
  type    = bool
  default = true
}

variable "APP_SETTINGS" {
  type    = map(string)
  default = {}
}

variable "TAGS" {
  type    = map(string)
  default = {}
}