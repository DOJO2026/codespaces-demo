variable "NAME" {
  type        = string
  description = "Azure AI Search service name - must be globally unique"
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "SKU" {
  type    = string
  default = "basic"
}

variable "TAGS" {
  type    = map(string)
  default = {}
}
