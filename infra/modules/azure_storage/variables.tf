variable "NAME" {
  type        = string
  description = "Storage account name - must be globally unique, 3-24 chars, only lowercase letters and numbers (no hyphens)"
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "CONTAINER_NAME" {
  type    = string
  default = "contenedor"
}

variable "TAGS" {
  type    = map(string)
  default = {}
}
