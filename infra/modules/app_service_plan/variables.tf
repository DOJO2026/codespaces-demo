variable "APP_SERVICE_PLAN_NAME" {
  type = string
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "SKU_NAME" {

  type = string

  default = "B1"

}

variable "OS_TYPE" {

  type = string

  default = "Linux"

}